Return-Path: <netdev+bounces-191270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40EBABA80C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 05:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEBE1BA421F
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 03:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A89317A2E3;
	Sat, 17 May 2025 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNukth2v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1688715B135;
	Sat, 17 May 2025 03:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747453993; cv=none; b=BmM52UWQ2uolSPbQv5IP3Oig/+apy5R8MJw+E5ojoFqttyg5JTpWMy9z5wF4uoZ8xzLB4OiTjLGkpJk+VctP/cvXjjtl6dqwZMCpZHDSnyOKCEf1++ZAecoz2sfADT2z7fYewobrJ5wx+FQsrS9vJz6irlsj55agetRD+PhyZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747453993; c=relaxed/simple;
	bh=Z2OgE+o7iRIOrIJibHhLgMVGarTa7YNSYIcKhznb4ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTurql3XgKtlsoZhGHiIEzFXOTBpFXoNthS006CCwBa9OFAAEuVSlOAGxeprWBiVKr9GwYoqaCTMpH5q+9jpkT/qIfBbqi4xgzxZRqtCThaP6wYSMKwRI5hZLwFhPLV7G4f1kRJdxwvpYS1lMhw1CEhC+MCxRbJ5N2LIroP6gLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNukth2v; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e09f57ed4so41712225ad.0;
        Fri, 16 May 2025 20:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747453991; x=1748058791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AU9AX5nZe+HwGHVNz/LjdEhTqsaZvsNtu0vy6tKooRs=;
        b=eNukth2vF1I96ijg1A1RcE3LNrgsRhkebdrlZqvzmJitkZsUUffkc9CKddIAJmaKnT
         cGprNnx1wwE9H5wjVMQY8fY2KKLWeAjuV1SvJBR7n91TFetw5CxMPTftcqkiZLst9tmf
         Oblbl+lg7ssTfm/nArKTulLNOOMcynw6MMxC18mA04pWL0hjet3dBzPltAoTybUXIyUH
         xWRswY82oSyVlKr1jG4ReRG7apb3pSbz9zJNUYkGG6axGhoUR1sJzhZAICPyOww+fqND
         oGsp1sNemgeXfYKYLn8IgTVnTphZVrXZY935i6U0bNRKyBnKvcRbhbkyJrzO8VcXRXwv
         MpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747453991; x=1748058791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU9AX5nZe+HwGHVNz/LjdEhTqsaZvsNtu0vy6tKooRs=;
        b=WY6jNAaYm12GwE0JdeBr9c9PwtbcuGJqWlTro5AqBO004xeTaiCGe/TULYFEGvNOVP
         HiacJLyhqDKuNnVchu15MfwdZ4MbPQBDI4cgFDiE21I+VI5nkRfgG/ZlFUZCeXmF6THF
         nMKA5D5U3Xi24/uStuhtVJtgJtpLlv5xIZjqGws0rrFKg9IEyJzwDOwhcbKDe5YR/hXt
         xdrAPY+HTD5oCsZWKxBB4i4QinoIrUwPnpJPFKPIEZLRcwLweeYi3/knPBRqU1SmPyEF
         ZIpBWn+XmhMnhNHAVALerPxXqiGyuWBtAD/CZaJU8M+ecM+zfNsM9or/q4aM69+8xkvS
         +Wqw==
X-Forwarded-Encrypted: i=1; AJvYcCWEvzRG1pqTYVugE61hxEUBvFpnbBj49xmh7W91pAVF335qui+oTOPGmbhqN+FCckC42ZrY6hIOaB1wykI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjVVJwf5sc5PHsxcoYcv8+vhrvIR33iGuoqx9JhSxtVCnGde4
	wPsf8iJX0SfB4I7UtF/4/U6TA5Kxv+32r3p2vxqDR30UfF+JIwkzivs=
X-Gm-Gg: ASbGncttfviTNtIuUQU38EEaFL4uHZT+mtfBnyE6UCPEHgMOsPiO1zhwN+7OLLCdG3j
	OMGT7hF22n17nkZ3pdKfQ+JHRMre7DSGj++ipE0LewcqP6zbmTkcjD3Xbm+hiua8QwP/eMq2Svc
	vfaXbYd5osoQS8cUjVofhikF3yH+Pn9WbsGix4qrkdQGxSJruvWbA1dH4Q+5tGpd5PXJel1tNXY
	QmdTFJ6u9HxwGTQdfwA+1fL8QnPicTFYvwmi/UkGv3rzkDoa+FTQTKa4RMGrvSZ4nG1A+dqmxlJ
	PlFy2BkJLxvkPJSyQOqlHy2oSf+tQmgesThUX2d9E32CHUwFaFpRusZWUEIqDJcI6gVkgJTHoL5
	nepE/kPkT0FYgdEEsatEmirU=
X-Google-Smtp-Source: AGHT+IEfgXSVlqXnInoPZPi6O3bY7TgPrDPC0fb2vY2tNK8vHLbIzpALlw5ZheZpjK3s5zT8ZYx//g==
X-Received: by 2002:a17:902:d2c1:b0:21f:6f33:f96 with SMTP id d9443c01a7336-231b3959f60mr129650825ad.6.1747453991184;
        Fri, 16 May 2025 20:53:11 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4ebb168sm21624745ad.204.2025.05.16.20.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:53:10 -0700 (PDT)
Date: Fri, 16 May 2025 20:53:09 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	willemb@google.com, sagi@grimberg.me, asml.silence@gmail.com,
	almasrymina@google.com, kaiyuanz@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: devmem: remove min_t(iter_iov_len) in
 sendmsg
Message-ID: <aCgIJSgv-yQzaHLl@mini-arch>
References: <20250517000431.558180-1-stfomichev@gmail.com>
 <20250517000907.GW2023217@ZenIV>
 <aCflM0LZ23d2j2FF@mini-arch>
 <20250517020653.GX2023217@ZenIV>
 <aCfxs5CiHYMJPOsy@mini-arch>
 <20250517033951.GY2023217@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250517033951.GY2023217@ZenIV>

On 05/17, Al Viro wrote:
> On Fri, May 16, 2025 at 07:17:23PM -0700, Stanislav Fomichev wrote:
> > > Wait, in the same commit there's
> > > +       if (iov_iter_type(from) != ITER_IOVEC)
> > > +               return -EFAULT;
> > > 
> > > shortly prior to the loop iter_iov_{addr,len}() are used.  What am I missing now?
> > 
> > Yeah, I want to remove that part as well:
> > 
> > https://lore.kernel.org/netdev/20250516225441.527020-1-stfomichev@gmail.com/T/#u
> > 
> > Otherwise, sendmsg() with a single IOV is not accepted, which makes not
> > sense.
> 
> Wait a minute.  What's there to prevent a call with two ranges far from each other?

It is perfectly possible to have a call with two disjoint ranges,
net_devmem_get_niov_at should correctly resolve it to the IOVA in the
dmabuf. Not sure I understand why it's an issue, can you pls clarify?

What we want to have here is:

1. sendmsg(msg.msg_iov = [{ .iov_base = .., .iov_len = x }])
2. sendmsg(msg.msg_iov = [{ .iov_base = .., .iov_len = x },
                          { .iov_base = .., .iov_len = y])

Both should be accepted. Currently only (2) works because of that ITER_IOVEC
check. Once I remove it, I hit the issue where iter_iov_len starts to
return too early.

(Documentation/networking/devmem.rst has a bit more info on the sendmsg UAPI
with dmabufs if that's still confusing)

