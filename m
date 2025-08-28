Return-Path: <netdev+bounces-217809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB642B39E1A
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B0016C28E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579327991C;
	Thu, 28 Aug 2025 13:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="096dface"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F615B54A
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386305; cv=none; b=uu7cBj7G8PwiKb9cJq8Wark38USBIQmJe50AoZUFLUzEucukZjCYrCT9Gor5ju7WzIbzBgk/n3SyHxF+a0jd/eVhl7s45seCegj5trzLQrPSptimvKJMFJqn9urUWzmBaY40bTgiW14azcmq6owhRMZe6nlRTlc0YL/MfZSxHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386305; c=relaxed/simple;
	bh=4fAIx5yru9GQ1oNMWIISu/qjLu+guUJf+LkE2eYtO20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXR6JNPFXHwwIZpIIcQKSUX7nv7/kJ0UUufTyV1q4EHthOGPWuVWsjBlVF6XQctGNB2KCrutCF4zMhpWwkjOtaLnrvkLXITC/ZmeTdNzR8aYGDlYWupVAO+KOBi916NO12pW0mtRzjlpQvMLVVqPJv/J4dzEdfNeEkP4nFQTf00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=096dface; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c7aa4ce85dso689735f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1756386300; x=1756991100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JpMfRZeR4SBFl0cDh4lqIpag2paKZt4hWT0Y+LU/kmQ=;
        b=096dfaceAUsTFZ33aS8IGKWFbKfxNFTBbwaJ+pUBeNOsCxpK/AuQ9TExq2aPmmdJSR
         +2kDUQnKpcW1aQ8R7bLmzCZD/27gj9z9n4p5CGMuK3qNntiHVO6gW6osaDcKuNvjJoDB
         vpVidYFcQDgeNSB1YjmA41ydN6DP+197pKNZpPdQUDdoUGv/PkUDx9X+QXeLkc35jkuz
         JN1z7vNoBz4iecjim354p9a8cAWvvHFL36gOCKTJyYcD+x2M5iYy0vnImyp0CpGboRbq
         TYi4dU9/AXNKE1pt3GQipCzn2tBds2qhb5SszwONC2PyqETTDujj/+28XXSiIpeZWUG3
         xMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386300; x=1756991100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JpMfRZeR4SBFl0cDh4lqIpag2paKZt4hWT0Y+LU/kmQ=;
        b=fhVJmatVidOg8oKssYDws9ZJmhU6HEOkgg3avr4uNjnGYBjy0Rc9MVmTXamPqoctRB
         SbjmJ9RDehHds1SQ+j+YelcmzWNLoLBo16WmzpaSo52XuHt8F02HeGoXZZmzkV73W45z
         ZseI4fzKzxRwtXKpfclwRRTSmC6K+Bj/w5Y0vjPgvUsjEBONxX9s5mVGhX5wqhn5TV5t
         Y6aIeJPKHP8qq9wBXFQfb7UJq9uxyhDiuNpHeOMHdB8eNj1xiCaoFm10dpxPHLSsXjBK
         BD4ingyhfQ27gGAwjiKvK8bMjipVa6VeMxFWClJLrYW25YRvxc60jP3vjFodWcllucN/
         VcTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1icYcqLPDLM0OEEvnnyNz3MEak94Q0KH5oJxXhFzihZY5sKiq+m7yRwqAS0mlM/wOZ3HjLYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxv7bY2als3Zhglb6LVP/rIXhPv0PqghXk1AeTi7k5Uqqtl3V
	ID0icyu2cOUDQN5iTJUR2zoxz3Le+2CXmsK/GmIP3atlqMGrSJpdwH5IAedXBXWOKT8=
X-Gm-Gg: ASbGncvJO25P/keOfcanR40hjgllXCufIU8hzBRXZVe8H+KWaP0bCzM1/5HAe1Dx5rQ
	oN5G1NnPjet7kQ6vCPM/zklDpL9hYs5JFsTdY9gE3plu97D/HZMNpGLDRZLZovqL24/aNdr7QUe
	IU5nlqk5a7dvyEQAaOJ9L+kvt8UsxJN8uAMyQ05bd1TXYUWfLrjzSPHdqX44MN3PSFz0Q2iW+YZ
	cUtCSCW3XmKetQhWhlSHsdac7uxqC5vYWDF0ZBBQOxt1tJ7exKP5qhsK1FjxGQK45QqAmtBl41l
	mVJceWrdopuSVcqegN9LKWE6xhczd4ToYoe9IXTWhQoaHLmtuzRaGW8/1VZXrhz2UGwfdn6ixVB
	hM7hWqyNLLKcsTAYmYw1XiSjt
X-Google-Smtp-Source: AGHT+IFZ63smbO+AqIfprJMFW4PEEowKUCB5lwDUFxsH7UZjhawV9nFc3J91PnU9b8bCjAn+l1PCqg==
X-Received: by 2002:a05:6000:420d:b0:3ce:ae6b:51d9 with SMTP id ffacd0b85a97d-3ceae6b5368mr728617f8f.26.1756386299405;
        Thu, 28 Aug 2025 06:04:59 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7d97b5bbsm2771445e9.1.2025.08.28.06.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:04:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 15:04:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: mohammad heib <mheib@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, przemyslawx.patynowski@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, jacob.e.keller@intel.com, 
	aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net v2] i40e: add devlink param to control VF MAC address
 limit
Message-ID: <zylu4kqwjx4rjatlsggo2v4lspxbkx4efb5mx7tvudhmfjsipz@vf74rx5bpr3l>
References: <20250823094952.182181-1-mheib@redhat.com>
 <pdanf5ciga5ddl7xyi2zkltcznyz4wtnyqyaqm7f5oqpcrubfz@ma4juoq4qlph>
 <f865bca4-40e3-4e65-9269-6c0f0ae9ad22@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f865bca4-40e3-4e65-9269-6c0f0ae9ad22@redhat.com>

Thu, Aug 28, 2025 at 02:49:26PM +0200, mheib@redhat.com wrote:
>Hi Jiri
>
>On 8/28/25 2:43 PM, Jiri Pirko wrote:
>> Sat, Aug 23, 2025 at 11:49:52AM +0200, mheib@redhat.com wrote:
>> > From: Mohammad Heib <mheib@redhat.com>
>> > 
>> > This patch introduces a new devlink runtime parameter that controls
>> > the maximum number of MAC filters allowed per VF.
>> > 
>> > The parameter is an integer value. If set to a non-zero number, it is
>> > used as a strict per-VF cap. If left at zero, the driver falls back to
>> > the default limit calculated from the number of allocated VFs and
>> > ports.
>> > 
>> > This makes the limit policy explicit and configurable by user space,
>> > instead of being only driver internal logic.
>> > 
>> > Example command to enable per-vf mac limit:
>> > - devlink dev param set pci/0000:3b:00.0 name max_mac_per_vf \
>> > 	value 12 \
>> > 	cmode runtime
>> > 
>> > - Previous discussion about this change:
>> >   https://lore.kernel.org/netdev/20250805134042.2604897-1-dhill@redhat.com
>> > 
>> > Fixes: cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every trusted VF")
>> > Signed-off-by: Mohammad Heib <mheib@redhat.com>
>> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> > ---
>> > Documentation/networking/devlink/i40e.rst     | 22 ++++++++
>> > drivers/net/ethernet/intel/i40e/i40e.h        |  4 ++
>> > .../net/ethernet/intel/i40e/i40e_devlink.c    | 56 ++++++++++++++++++-
>> > .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 25 +++++----
>> > 4 files changed, 95 insertions(+), 12 deletions(-)
>> > 
>> > diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
>> > index d3cb5bb5197e..f8d5b00bb51d 100644
>> > --- a/Documentation/networking/devlink/i40e.rst
>> > +++ b/Documentation/networking/devlink/i40e.rst
>> > @@ -7,6 +7,28 @@ i40e devlink support
>> > This document describes the devlink features implemented by the ``i40e``
>> > device driver.
>> > 
>> > +Parameters
>> > +==========
>> > +
>> > +.. list-table:: Driver specific parameters implemented
>> > +    :widths: 5 5 90
>> > +
>> > +    * - Name
>> > +      - Mode
>> > +      - Description
>> > +    * - ``max_mac_per_vf``
>> > +      - runtime
>> > +      - Controls the maximum number of MAC addresses a VF can use on i40e devices.
>> > +
>> > +        By default (``0``), the driver enforces its internally calculated per-VF
>> > +        MAC filter limit, which is based on the number of allocated VFS.
>> > +
>> > +        If set to a non-zero value, this parameter acts as a strict cap:
>> > +        the driver enforces the maximum of the user-provided value and ignore
>> > +        internally calculated limit.
>> > +
>> > +        The default value is ``0``.
>> > +
>> > Info versions
>> > =============
>> > 
>> > diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>> > index 801a57a925da..d2d03db2acec 100644
>> > --- a/drivers/net/ethernet/intel/i40e/i40e.h
>> > +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>> > @@ -574,6 +574,10 @@ struct i40e_pf {
>> > 	struct i40e_vf *vf;
>> > 	int num_alloc_vfs;	/* actual number of VFs allocated */
>> > 	u32 vf_aq_requests;
>> > +	/* If set to non-zero, the device uses this value
>> > +	 * as maximum number of MAC filters per VF.
>> > +	 */
>> > +	u32 max_mac_per_vf;
>> > 	u32 arq_overflows;	/* Not fatal, possibly indicative of problems */
>> > 	struct ratelimit_state mdd_message_rate_limit;
>> > 	/* DCBx/DCBNL capability for PF that indicates
>> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> > index cc4e9e2addb7..8532e40b5c7d 100644
>> > --- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> > +++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
>> > @@ -5,6 +5,42 @@
>> > #include "i40e.h"
>> > #include "i40e_devlink.h"
>> > 
>> > +static int i40e_max_mac_per_vf_set(struct devlink *devlink,
>> > +				   u32 id,
>> > +				   struct devlink_param_gset_ctx *ctx,
>> > +				   struct netlink_ext_ack *extack)
>> > +{
>> > +	struct i40e_pf *pf = devlink_priv(devlink);
>> > +
>> > +	pf->max_mac_per_vf = ctx->val.vu32;
>> > +	return 0;
>> > +}
>> > +
>> > +static int i40e_max_mac_per_vf_get(struct devlink *devlink,
>> > +				   u32 id,
>> > +				   struct devlink_param_gset_ctx *ctx)
>> > +{
>> > +	struct i40e_pf *pf = devlink_priv(devlink);
>> > +
>> > +	ctx->val.vu32 = pf->max_mac_per_vf;
>> > +	return 0;
>> > +}
>> > +
>> > +enum i40e_dl_param_id {
>> > +	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>> > +	I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>> What's so i40 specific about this? Sounds pretty generic to be.
>> 
>> 
>> 
>> > +};
>> > +
>> > +static const struct devlink_param i40e_dl_params[] = {
>> > +	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_MAX_MAC_PER_VF,
>> > +			     "max_mac_per_vf",
>> > +			     DEVLINK_PARAM_TYPE_U32,
>> > +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> > +			     i40e_max_mac_per_vf_get,
>> > +			     i40e_max_mac_per_vf_set,
>> > +			     NULL),
>> > +};
>> > +
>> > static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
>> > {
>> > 	u8 dsn[8];
>> > @@ -165,7 +201,19 @@ void i40e_free_pf(struct i40e_pf *pf)
>> >   **/
>> > void i40e_devlink_register(struct i40e_pf *pf)
>> > {
>> > -	devlink_register(priv_to_devlink(pf));
>> > +	int err;
>> > +	struct devlink *dl = priv_to_devlink(pf);
>> > +	struct device *dev = &pf->pdev->dev;
>> > +
>> > +	err = devlink_params_register(dl, i40e_dl_params,
>> > +				      ARRAY_SIZE(i40e_dl_params));
>> > +	if (err) {
>> > +		dev_err(dev,
>> > +			"devlink params register failed with error %d", err);
>> > +	}
>> > +
>> > +	devlink_register(dl);
>> > +
>> > }
>> > 
>> > /**
>> > @@ -176,7 +224,11 @@ void i40e_devlink_register(struct i40e_pf *pf)
>> >   **/
>> > void i40e_devlink_unregister(struct i40e_pf *pf)
>> > {
>> > -	devlink_unregister(priv_to_devlink(pf));
>> > +	struct devlink *dl = priv_to_devlink(pf);
>> > +
>> > +	devlink_unregister(dl);
>> > +	devlink_params_unregister(dl, i40e_dl_params,
>> > +				  ARRAY_SIZE(i40e_dl_params));
>> > }
>> > 
>> > /**
>> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> > index 081a4526a2f0..e7c0c791eed1 100644
>> > --- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> > +++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
>> > @@ -2935,19 +2935,23 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>> > 		if (!f)
>> > 			++mac_add_cnt;
>> > 	}
>> > -
>> > -	/* If this VF is not privileged, then we can't add more than a limited
>> > -	 * number of addresses.
>> > +	/* Determine the maximum number of MAC addresses this VF may use.
>> > +	 *
>> > +	 * - For untrusted VFs: use a fixed small limit.
>> > +	 *
>> > +	 * - For trusted VFs: limit is calculated by dividing total MAC
>> > +	 *  filter pool across all VFs/ports.
>> > 	 *
>> > -	 * If this VF is trusted, it can use more resources than untrusted.
>> > -	 * However to ensure that every trusted VF has appropriate number of
>> > -	 * resources, divide whole pool of resources per port and then across
>> > -	 * all VFs.
>> > +	 * - User can override this by devlink param "max_mac_per_vf".
>> > +	 *   If set its value is used as a strict cap.
>> > 	 */
>> > -	if (!vf_trusted)
>> > +	if (!vf_trusted) {
>> > 		mac_add_max = I40E_VC_MAX_MAC_ADDR_PER_VF;
>> > -	else
>> > +	} else {
>> > 		mac_add_max = I40E_VC_MAX_MACVLAN_PER_TRUSTED_VF(pf->num_alloc_vfs, hw->num_ports);
>> > +		if (pf->max_mac_per_vf > 0)
>> > +			mac_add_max = pf->max_mac_per_vf;
>> > +	}
>> > 
>> > 	/* VF can replace all its filters in one step, in this case mac_add_max
>> > 	 * will be added as active and another mac_add_max will be in
>> > @@ -2961,7 +2965,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
>> > 			return -EPERM;
>> > 		} else {
>> > 			dev_err(&pf->pdev->dev,
>> > -				"Cannot add more MAC addresses, trusted VF exhausted it's resources\n");
>> > +				"Cannot add more MAC addresses: trusted VF reached its maximum allowed limit (%d)\n",
>> > +				mac_add_max);
>> > 			return -EPERM;
>> > 		}
>> > 	}
>> > -- 
>> > 2.47.3
>> > 
>If i understand correctly, you’re asking whether this parameter could be
>added as a generic devlink parameter
>rather than a driver-specific one?
>
>
>if that the case, Yes, it could be made generic, but I initially implemented
>it as driver specific because I was targeting i40e only,
>and I thought a generic approach might not be acceptable at this stage
>
>
>I do plan to extend this to other drivers, as mentioned in the v1 patch here:
> - https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20250821233930.127420-1-mheib@redhat.com/
>For now, i'm pushing hard to get this patch into i40e since it affects a
>customer. Once it's accepted i can extend it
>to other drivers and convert it to the generic devlink parameter.

No, please do it as generic from start. Thanks!

>
>
>Thanks,
>

