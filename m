Return-Path: <netdev+bounces-37441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F27307B55FB
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 17:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 56F35B20C31
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1836D1A72D;
	Mon,  2 Oct 2023 15:04:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0E18E30
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 15:04:24 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CD99D
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:04:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so6988948a12.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696259061; x=1696863861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QvJNZIXntn7YAjmySz9d+Qe4GmC8D4FRYo7VLjmUagg=;
        b=PmOsbOowTPlPKvSgp51WK+yawaOQ7SsUua61gz2J0TCgP5ol51ex95CaKjhUL2TcMt
         fxj1TvTpL3mS8x1XzQfe99NoN/fewq7h1QZQjeQfozJX6Ki++TBqOpZmySploUX2me7f
         /YlOrk1h5k+yVX/dP4qzvaqu85X8LKnVeYWZN82t/uLTwAySHlvdEzbreSw1dy9V2HkT
         1usaHVvoo32eDpmzQBWpy/C0qe+gT6bljlFUAoyduKFtTDmq974UlUGfopkoFd1nRKLI
         5qp1IShEJiSA6OF5aGxkwWRABgEIw2I6In8X2X7Sz8UpWw9dvi4xrYeU7K3btJlh6o/e
         yfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696259061; x=1696863861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvJNZIXntn7YAjmySz9d+Qe4GmC8D4FRYo7VLjmUagg=;
        b=m8TmzfLcmStQTis5jDMZgleMMfHj8iQT34GTcHB8rfNrZvFzxfoaKou9BM9L8QSI+I
         NSZLVszetBSKyYiqg8w1yzJ6kQFXsZa5+thE7IHQtCWjjstG0DpM2VFvGsRg0Toz/ZVr
         4s8H5Qan8UCBFBhk3BGiMQJIuice6jPk94R4znHAlXmy8cJx9T1E0C+uEd0yU/AXbvpG
         LoErNpbMrTU2Cm6Tp6xbAZ4WfDbqkJDeYRcNR1m8IdCDEf15y0LvnEFY03qYSIg8IQVr
         0oBXr7b/Kpmbk1M0EAk3w9o2fIttrx6fyiLrjOoo4neuapLgICC8dHzhQgXpWl0VZeGZ
         roKw==
X-Gm-Message-State: AOJu0Yww0HVFx9qVufOGO4mxmDb12SJJWzVOiF64iUOqQcEkrMJT9Bvp
	JK5QFQ4f6sG1DlLO1bQn5aVuJA==
X-Google-Smtp-Source: AGHT+IFqh9NllzilyvM7mFV52YUwfOckVeUvhQSKiDUSgq1yDje1H5h8BEDhUqmgu0imlejHcXw1yQ==
X-Received: by 2002:a17:907:948b:b0:9a5:aa43:1c7c with SMTP id dm11-20020a170907948b00b009a5aa431c7cmr11678072ejc.26.1696259061042;
        Mon, 02 Oct 2023 08:04:21 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id lz1-20020a170906fb0100b0099b5a71b0bfsm17185248ejb.94.2023.10.02.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 08:04:20 -0700 (PDT)
Date: Mon, 2 Oct 2023 17:04:19 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: Re: [PATCH net-next 3/4] dpll: netlink/core: add support for
 pin-dpll signal phase offset/adjust
Message-ID: <ZRrb87drG7aVrxsT@nanopsycho>
References: <20230927092435.1565336-1-arkadiusz.kubalewski@intel.com>
 <20230927092435.1565336-4-arkadiusz.kubalewski@intel.com>
 <4018c0b0-b288-ff60-09be-7ded382f4a82@linux.dev>
 <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB4657AA79C0C44F868499A3129BC5A@DM6PR11MB4657.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Oct 02, 2023 at 04:32:30PM CEST, arkadiusz.kubalewski@intel.com wrote:
>>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>Sent: Wednesday, September 27, 2023 8:09 PM
>>
>>On 27/09/2023 10:24, Arkadiusz Kubalewski wrote:
>>> Add callback op (get) for pin-dpll phase-offset measurment.
>>> Add callback ops (get/set) for pin signal phase adjustment.
>>> Add min and max phase adjustment values to pin proprties.
>>> Invoke get callbacks when filling up the pin details to provide user
>>> with phase related attribute values.
>>> Invoke phase-adjust set callback when phase-adjust value is provided for
>>> pin-set request.
>>>
>>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>>
>>[...]
>>
>>> +static int
>>> +dpll_pin_phase_adj_set(struct dpll_pin *pin, struct nlattr
>>> *phase_adj_attr,
>>> +		       struct netlink_ext_ack *extack)
>>> +{
>>> +	struct dpll_pin_ref *ref;
>>> +	unsigned long i;
>>> +	s32 phase_adj;
>>> +	int ret;
>>> +
>>> +	phase_adj = nla_get_s32(phase_adj_attr);
>>> +	if (phase_adj > pin->prop->phase_range.max ||
>>> +	    phase_adj < pin->prop->phase_range.min) {
>>> +		NL_SET_ERR_MSG(extack, "phase adjust value not supported");
>>> +		return -EINVAL;
>>> +	}
>>> +	xa_for_each(&pin->dpll_refs, i, ref) {
>>> +		const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>>> +		struct dpll_device *dpll = ref->dpll;
>>> +
>>> +		if (!ops->phase_adjust_set)
>>> +			return -EOPNOTSUPP;
>>
>>I'm thinking about this part. We can potentially have dpll devices with
>>different expectations on phase adjustments, right? And if one of them
>>won't be able to adjust phase (or will fail in the next line), then
>>netlink will return EOPNOTSUPP while _some_ of the devices will be
>>adjusted. Doesn't look great. Can we think about different way to apply
>>the change?
>>
>
>Well makes sense to me.
>
>Does following makes sense as a fix?
>We would call op for all devices which has been provided with the op.
>If device has no op -> add extack error, continue

Is it real to expect some of the device support this and others don't?
Is it true for ice?
If not, I would got for all-or-nothing here.


>If device fails to set -> add extack error, continue
>Function always returns 0.
>
>Thank you!
>Arkadiusz
>
>>
>>> +		ret = ops->phase_adjust_set(pin,
>>> +					    dpll_pin_on_dpll_priv(dpll, pin),
>>> +					    dpll, dpll_priv(dpll), phase_adj,
>>> +					    extack);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +	__dpll_pin_change_ntf(pin);
>>> +
>>> +	return 0;
>>> +}
>>> +

