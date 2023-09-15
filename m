Return-Path: <netdev+bounces-34095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288727A2123
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD4D1C20B74
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222C30CFA;
	Fri, 15 Sep 2023 14:35:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EEF30CF9
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:35:40 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024C91AC;
	Fri, 15 Sep 2023 07:35:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a58dbd5daeso297039766b.2;
        Fri, 15 Sep 2023 07:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694788537; x=1695393337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5b78G1Xe/uMbbRctSNTpM0K2JqIF7YMEFr4py30NLE=;
        b=HWxGzrJStLkjqprmbesLMwZHt2KgWITMMlVYsCUYqLcjNZQXNSH5bvEYeeG0kWYX3L
         auMoieZp1kTmPj3NDPQjB0gwBHg7AL6z6V6vKXIKjcKW1b5Sk6Ij4u58Xlzi2+ffGCZy
         Ru6nt/Djge5YekPGxgB1p/dD269JhKysMbY6QiNcPVara850Mte7ejlufyLqi2CaAFwc
         csJkwvRd1GjKEzbjbUkV6K8b3Z+8sE3Q6O3vjWeZOCp7lY8rAedUhXqJOg7RlcYoI9/i
         8OATMBT8q3VZPTu6UToSDC/vSylAuU/bFrDd1Yy6s1/V8LXkhrlY4M6daNNljuYUgJbW
         jUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694788537; x=1695393337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5b78G1Xe/uMbbRctSNTpM0K2JqIF7YMEFr4py30NLE=;
        b=YkVc1P1ghCa+boRDAm7cEtFip4LIs/nAGYlIM91DVHkzo8o+OCvh1P6AVv8OKNOQDV
         9ukKzN+0UgUbhfIkIzwmk9VJwnP1emoC/omjzvJm2GWSapbt9ZiyqkrPR4A+bjxze+rW
         9qbm65RPtjV7CQGOdJ/3gpsLTWbIe35UFrRHvLxcNSUn2hImx61YSHXrNK3bfDYetku+
         sJ26UeXJ/imVn2IShShkZCOyMK+eci0kip6hxJlWbgtQSb2YE+UXEC1u4RSlJmG/FBnF
         nbuuFovb1hvsZe0zecSdKEcYSNd8pia0JBd90o4YlEts8fRUqtrOfxVtMGzyLOrihxyr
         Af/Q==
X-Gm-Message-State: AOJu0YxPJAu1E0usK4uf2EP7zahmkyzd17m352r3XCzJ/tjKlsyTxAum
	Z8vR9lF8s1yg2FwYGhYDYLo=
X-Google-Smtp-Source: AGHT+IHytT7TY6J2KcsVUkzYbrU3p/H/odEN/sgR1tTx2/e5kV95KT0xFxKFjrWPLpdywweLHcKAcQ==
X-Received: by 2002:a17:906:150:b0:9a5:cab0:b061 with SMTP id 16-20020a170906015000b009a5cab0b061mr1613521ejh.51.1694788537224;
        Fri, 15 Sep 2023 07:35:37 -0700 (PDT)
Received: from skbuf ([188.26.56.202])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b009a1a653770bsm2531814ejc.87.2023.09.15.07.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 07:35:36 -0700 (PDT)
Date: Fri, 15 Sep 2023 17:35:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
	Petr Machata <petrm@nvidia.com>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH net-next 1/2] net: dsa: microchip: Move *_port_setup code
 to dsa_switch_ops::port_setup()
Message-ID: <20230915143534.upiemn6ytjhmcot7@skbuf>
References: <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914131145.23336-1-o.rempel@pengutronix.de>
 <20230914131145.23336-1-o.rempel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 14, 2023 at 03:11:44PM +0200, Oleksij Rempel wrote:
> Right now, the *_port_setup code is in dsa_switch_ops::port_enable(),
> which is not the best place for it. This patch moves it to a more
> suitable place, dsa_switch_ops::port_setup(), to match the function's
> purpose and name.
> 
> This patch is a preparation for coming ACL support patch.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

