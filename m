Return-Path: <netdev+bounces-18713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8961775859B
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 21:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6714F1C20DE2
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98AC171BF;
	Tue, 18 Jul 2023 19:34:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93D2171BE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 19:34:50 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2A2198D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 12:34:48 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qLqT6-00011A-1F;
	Tue, 18 Jul 2023 19:34:44 +0000
Date: Tue, 18 Jul 2023 20:34:37 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <ZLbpTWT0StW0AnqX@makrotopia.org>
References: <20230624205629.4158216-1-andrew@lunn.ch>
 <20230624205629.4158216-2-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624205629.4158216-2-andrew@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jun 24, 2023 at 10:56:27PM +0200, Andrew Lunn wrote:
> When the netdev trigger is activates, it tries to determine what
> device the LED blinks for, and what the current blink mode is.
> 
> The documentation for hw_control_get() says:
> 
> 	 * Return 0 on success, a negative error number on failing parsing the
> 	 * initial mode. Error from this function is NOT FATAL as the device
> 	 * may be in a not supported initial state by the attached LED trigger.
> 	 */
> 
> For the Marvell PHY and the Armada 370-rd board, the initial LED blink
> mode is not supported by the trigger, so it returns an error. This
> resulted in not getting the device the LED is blinking for. As a
> result, the device is unknown and offloaded is never performed.
> 
> Change to condition to always get the device if offloading is
> supported, and reduce the scope of testing for an error from
> hw_control_get() to skip setting trigger internal state if there is an
> error.
> 
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger/ledtrig-netdev.c
> index 32b66703068a..247b100ee1d3 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -565,15 +565,17 @@ static int netdev_trig_activate(struct led_classdev *led_cdev)
>  	/* Check if hw control is active by default on the LED.
>  	 * Init already enabled mode in hw control.
>  	 */
> -	if (supports_hw_control(led_cdev) &&
> -	    !led_cdev->hw_control_get(led_cdev, &mode)) {
> +	if (supports_hw_control(led_cdev)) {
>  		dev = led_cdev->hw_control_get_device(led_cdev);
>  		if (dev) {
>  			const char *name = dev_name(dev);
>  
>  			set_device_name(trigger_data, name, strlen(name));
>  			trigger_data->hw_control = true;
> -			trigger_data->mode = mode;
> +
> +			rc = led_cdev->hw_control_get(led_cdev, &mode);

Shouldn't there also be something like
led_cdev->hw_control_get(led_cdev, 0);
in netdev_trig_deactivate then?
Because somehow we need to tell the hardware to no longer perform an
offloading operation.

> +			if (!rc)
> +				trigger_data->mode = mode;
>  		}
>  	}
>  
> -- 
> 2.40.1
> 
> 

