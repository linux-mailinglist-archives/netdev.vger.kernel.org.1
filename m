Return-Path: <netdev+bounces-221767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB7B51D45
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1481743F1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B5D3314B5;
	Wed, 10 Sep 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sddu5nOv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E460261B81;
	Wed, 10 Sep 2025 16:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520814; cv=none; b=UoEosDpREwt5oiMtwHF5feYYGgj99VOPI4lbZW3BxlHRJI0HFfGe5EHQE0gdh69A8l/RgPJKttYi+g/bi3sWOiiX2qheaCdyQngPqGQfwyhq7i33X+ls9ralU/nH7kt5xudV36Qbv75CjaHmQ8oL8LRMUWJlagBUnIp+xJPSGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520814; c=relaxed/simple;
	bh=MV39y2Xl/uahnxe2dsMAhx/+KnRqygZKLmJRmVcf5Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZrW0JD9DGeVxy213ovKuTI72OLQYJWQ8VcQGTk0I92s+1ft87ww5rZ3JZywhvVRhryYvjM9FDECbaAKSDf0jVhiXZtltA2S4KJGBD6bTaN1loPv/MK3TqcMugP0W3S2Tht1LYhy3h5CwCAl/kF3cdIMai744bq77C7RwcRlQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sddu5nOv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xLlQAdX9EKuLPni5mv0BQWTJbO5P/J2GkEBcV1lVcTo=; b=Sddu5nOv/xqB0VhycUgjA123tZ
	I01vOGUkrQizRG48DnnMXA51nL1l4Lo2uEQNvoq8w5S0YEMJ/qYsEUKmOlxPohBF8l2WkoWgMX01E
	tbz1hmFpmE3PQTnyfJ4m1Asd2aLUNcLfkS6yHNCMBe7bg8+Lnxd0YfpiFFerkBturacI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwNRh-007y94-Op; Wed, 10 Sep 2025 18:13:21 +0200
Date: Wed, 10 Sep 2025 18:13:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] dpll: zl3073x: Allow to use custom phase
 measure averaging factor
Message-ID: <acfc8c63-4434-4738-84a9-00360e70c773@lunn.ch>
References: <20250910103221.347108-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910103221.347108-1-ivecera@redhat.com>

On Wed, Sep 10, 2025 at 12:32:21PM +0200, Ivan Vecera wrote:
> The DPLL phase measurement block uses an exponential moving average,
> calculated using the following equation:
> 
>                        2^N - 1                1
> curr_avg = prev_avg * --------- + new_val * -----
>                          2^N                 2^N
> 
> Where curr_avg is phase offset reported by the firmware to the driver,
> prev_avg is previous averaged value and new_val is currently measured
> value for particular reference.
> 
> New measurements are taken approximately 40 Hz or at the frequency of
> the reference (whichever is lower).
> 
> The driver currently uses the averaging factor N=2 which prioritizes
> a fast response time to track dynamic changes in the phase. But for
> applications requiring a very stable and precise reading of the average
> phase offset, and where rapid changes are not expected, a higher factor
> would be appropriate.
> 
> Add devlink device parameter phase_offset_avg_factor to allow a user
> set tune the averaging factor via devlink interface.
> 
> Tested-by: Prathosh Satish <Prathosh.Satish@microchip.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  Documentation/networking/devlink/zl3073x.rst |  4 ++
>  drivers/dpll/zl3073x/core.c                  |  6 +-
>  drivers/dpll/zl3073x/core.h                  |  8 ++-
>  drivers/dpll/zl3073x/devlink.c               | 67 ++++++++++++++++++++
>  4 files changed, 82 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/devlink/zl3073x.rst b/Documentation/networking/devlink/zl3073x.rst
> index 4b6cfaf386433..ddd159e39e616 100644
> --- a/Documentation/networking/devlink/zl3073x.rst
> +++ b/Documentation/networking/devlink/zl3073x.rst
> @@ -20,6 +20,10 @@ Parameters
>       - driverinit
>       - Set the clock ID that is used by the driver for registering DPLL devices
>         and pins.
> +   * - ``phase_offset_avg_factor``
> +     - runtime
> +     - Set the factor for the exponential moving average used by DPLL phase
> +       measurement block. The value has to be in range <0, 15>.

Maybe put the text in the commit message here as well?

      Andrew

