Return-Path: <netdev+bounces-182473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FC9A88D85
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A437417B8FC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A60A1B3956;
	Mon, 14 Apr 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JflObhho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243C8BA49
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744664426; cv=none; b=CqHSOxunwH0vh6mlKJJdg/hPB+24eOENrwIUIlblL6nMglcOPTxolE7ZhmY0XzbcwRexe5cGpAePC43B8v8XzeP5pfQHuJ7mOaF/jKF2wf4nSPu/tRTo27CbYE86fIiC0wW0hbDjdtH0X1BuBirRrPp4LBAYxDPXReYkcabHGNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744664426; c=relaxed/simple;
	bh=kddSanEcB4wWlGRsfQGJ9zMSAc4vojgbbRtlVIxVwRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHAv4YQP4yS08O2M34/gQi4iY11ZAkijQZ7yFfJzYurkQF5hwKIS3YbiU4H6k4rOdlPeW6Z0srn7DJQ2mKPB4nTHdsxjp7eJ2kjJQAlDkrZB+PP9vJ35S/6ZK0ifuperTVTmYTtwvhTPaD4/oeZ8SndW9+JJwNEu1Ey100WEvYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JflObhho; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22928d629faso46790235ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744664424; x=1745269224; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vm+ahcePpEvfORK8kjXFf+7D2fNcBjGT14rMoukAMVY=;
        b=JflObhho3nRbDk+46zbOZjAvub2zTbtZwlSQCadaqzIpJsopT9e66qLrsn1Djsog9f
         j11AIII4O7i6ADpHjT5+PLBCak/cJ5804mAnUqHplbzuHA80CjAe6SmkdItZSO1QCyIT
         w1AhwEogO2Ncj6+pqw8i0rKzWNp/hkWiL/cG426BNIUtwk948zFPblLQHpUJSoFL7GUu
         1JRyu6FT//xGzShEFxB1OBX8dBwkNNHFNXLxRw5IaHsntV13YGSP7xPG6nS+LkU9L6WM
         TwpBuX5eDcOJi09p3QPa7Tx1fToUjVACCkhSr1G7ZnGcHEYqEiKydCse14q5e+2OGjRg
         MQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744664424; x=1745269224;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm+ahcePpEvfORK8kjXFf+7D2fNcBjGT14rMoukAMVY=;
        b=fz/Wou7WrYM8Aj+4hLBciDCbb9bMNplz9YS3KeaVJAw4gCEgBJcKHPw8IUtLwgauwa
         xTnyWE/nlweVt+KX8DDdhodnS9NdV8A3nVWkQ0g4jujwqFdrNZ1glLbPuMXQiBsXSiXR
         LILANGbWdo86lwxZhNBP5UqBHNtceYw80rtMx1I6nIqAGA0IZG6a6f/UP8kRJvkVpnYK
         HKhtyklHCQOudATMRtg2LjZIEDcWpMHU6iLj79QSmwhF+oCo3zRKZNRbKLEbfhP4zyhg
         STSY3xHUn4QWhYF8enrwpbneJ+UE1M8DI178hauIkT28ROSrktJfsrT+c2hii9yXXZGU
         /0xw==
X-Forwarded-Encrypted: i=1; AJvYcCWXSTQahskAMGWakvL40BVu6UcpsCrsYWaA2F8qEWHgl2l3VVib8kG0E/dZY49pZyC9Qq/Y1WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMQpKgZsvoaRAEnF+hnMycMfzhe4gKaRWhPCx0eLtiJNZG79D
	lL991jSNdr4iN5btp2XopLmEXypqiKIbmCVl2vhmU5F6nt4ivYDL
X-Gm-Gg: ASbGncvNdoA+ZW9dyw1x1b+3whzuW+8rnZ4P/gV/TGwcq3EsIZ/h9m5Kddipch49k5n
	ZtVwi+muXgJUuCv9VZaCzZ4XhhYz1KQ2OoC3rdqgWz8BUEdKQU0XM4YdSDsiWRVrp1RGw0kWTAq
	bhgqi3hAqmZi5wws/zgeigHkh2kban4PNgj1onlU8kV0aSoS3+Pjg4wBM+xJyVguJrkhJ5FEk34
	h6GkR1tMHrUFmomVry6xJuj8Oi2S7zgmy4uC2LXOLVhH+fRuCDRLXfyxZC5sP6/TIs1PiyK59wV
	DnNaKDraH+gKdyNKKRQEHLyozdOlMYyrJHQESQt68pVrMZWSQXyx+qo=
X-Google-Smtp-Source: AGHT+IHbQFI7R3NMBevPMSyEgkB8PsA3P26uYKCOLCrFhcRjVZj5zteUYqXJRO2xVJ8b8XvInEXYIg==
X-Received: by 2002:a17:903:2a8e:b0:211:e812:3948 with SMTP id d9443c01a7336-22bea3dae39mr211365335ad.0.1744664424232;
        Mon, 14 Apr 2025 14:00:24 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21c3943sm7111633b3a.37.2025.04.14.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 14:00:23 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:00:22 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
	Ilya Maximets <i.maximets@redhat.com>,
	Frode Nordahl <frode.nordahl@canonical.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
Message-ID: <Z/13ZnIO0EfF29/N@pop-os.localdomain>
References: <20250407105542.16601-1-toke@redhat.com>
 <Z/awKFETLHDwN6dE@pop-os.localdomain>
 <874iywux7o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874iywux7o.fsf@toke.dk>

On Thu, Apr 10, 2025 at 12:28:43PM +0200, Toke Høiland-Jørgensen wrote:
> Cong Wang <xiyou.wangcong@gmail.com> writes:
> 
> > On Mon, Apr 07, 2025 at 12:55:34PM +0200, Toke Høiland-Jørgensen wrote:
> >> +static struct sk_buff *tfilter_notify_prep(struct net *net,
> >> +					   struct sk_buff *oskb,
> >> +					   struct nlmsghdr *n,
> >> +					   struct tcf_proto *tp,
> >> +					   struct tcf_block *block,
> >> +					   struct Qdisc *q, u32 parent,
> >> +					   void *fh, int event,
> >> +					   u32 portid, bool rtnl_held,
> >> +					   struct netlink_ext_ack *extack)
> >> +{
> >> +	unsigned int size = oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GOODSIZE;
> >> +	struct sk_buff *skb;
> >> +	int ret;
> >> +
> >> +retry:
> >> +	skb = alloc_skb(size, GFP_KERNEL);
> >> +	if (!skb)
> >> +		return ERR_PTR(-ENOBUFS);
> >> +
> >> +	ret = tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
> >> +			    n->nlmsg_seq, n->nlmsg_flags, event, false,
> >> +			    rtnl_held, extack);
> >> +	if (ret <= 0) {
> >> +		kfree_skb(skb);
> >> +		if (ret == -EMSGSIZE) {
> >> +			size += NLMSG_GOODSIZE;
> >> +			goto retry;
> >
> > It is a bit concerning to see this technically unbound loop.
> 
> Well, I did think about that. The loop will terminate eventually by
> either succeeding, or failing the allocation. Most likely the former,
> since this is only called after a filter has been successfully
> installed. I.e., it's not like the amount of data being put into the skb
> is unbounded.

Yeah, I totally agree, it is probably just a theoretical problem.

> 
> >> +		}
> >> +		return ERR_PTR(-EINVAL);
> >
> > I think you probably want to propagate the error code from
> > tcf_fill_node() here.
> 
> I just kept the existing return value (of tfilter_notify()) for the same
> error case. tcf_fill_node() always returns -1 on error, so I think it
> makes more sense to keep this?
> 
> Paolo already merged the patch, and I don't think it's worth it to
> follow up with any fixes, cf the above. WDYT?

Not a big deal, we can keep as it is.

Thanks.

