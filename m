Return-Path: <netdev+bounces-104446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A8290C907
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446AA1F22200
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA313C82C;
	Tue, 18 Jun 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BJKyO5B2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FE12AAC9
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705416; cv=none; b=i2jdfTs6zc5mkpaZJST3j3TpWZwE8Gvd+AVQxsPICrWvRs9Z18i5tX64hZRoKew3Roe6U/hBdBB37bw/pjyusI2uQlZcbjyUNCgsNu++6y18b0sTcFARSKLUgWWQfo2IF6bh4ZMwu6HONDafj3hQ4QsIEr3l/p67RGAkPMiU9hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705416; c=relaxed/simple;
	bh=xBlSITPDrWMGqBk7RX81DxBRK6FBCQLiSeBn0AOw/FA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M7qi076WAefBvUk838z0T30R4v5WCShEfkZBa29GGb/QZZNRgZcPd1k/QSyLTu7ko2cnkqu1VDZ2w6LzlAUAdXu7KA+YmBd5Iqd35u4l89rv5CSlIhERufiJGzWaOxP1IX6s7kIqgGE1PkK1PgndoBrntptDyc0PuFcUjyViPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BJKyO5B2; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4217a96de38so38344085e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718705413; x=1719310213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFv+H+J5KVtQDId7j7CojiPG2lRqqZRtUi9PX0uMdRw=;
        b=BJKyO5B2iYwZX5w5Z8GksLGryr0x7kGKy6hXKplhu+Gg4Wqc6xRn1aRq3NAysVFtHs
         QQA9FH/FVvstw+s31uxNprWq9ZiFuV3rPsODyX6vI2N2R/Vqz0odb/EGXMQtZV0s5pp0
         pqRcLCotYc3R3MY1QXPzqB6HDnQE+CzSiS7LzMA4kYnTmagcbySnE/384mPkr1R4x7x7
         +xzNfxRtT/rf7oHqbL18WOO88XTpyUQlfkR7sFCZg8lmukSI+hU/arHKkLbQpqlw+5WA
         9LsS8ANiVOyix1n++EdKuV4nJOocIRJRsq1psQg5McIiJus4mT9Sbc2LNCsayBexv9pn
         IpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718705413; x=1719310213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFv+H+J5KVtQDId7j7CojiPG2lRqqZRtUi9PX0uMdRw=;
        b=C2IfwLPTZZpPUYeZq2HNMlrzjU2D5pyJ+hrq/fPB2hvQV6ZQShBAAJz9FUCv5mOYfg
         q0WwTQ6LsCgn1MdVycEyyxj4KPvx3YaUCLwb1ykjNZzRHFPx6dbEBklC7CfGG7J3/moi
         4TZYhhBD/8NkwJchM6jvUt1gZtjxS9BRDxLZXMVqtM0UQK31KWyiV7mzT4anvZJxRPxb
         UnnQQ2LDnCSNTPJEfd2j6HKWU1uMc0QfVCLy/GziY7OKzjG26r56zb2t0+bIuA8YzKt0
         gMeBJhlxy8P8EW6ZaCFVFQpkj3WQ9atSC+BjQukv3DPnxYffXUOYvIcyMtyCbAKwQpW5
         Q/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUsP2bb7j1iQ/CEx/r5jfihb3UtSF+t56Xix3SZsA4zB/elJdvkJuWOsW6CbK9Aax9co+0wczI+F7odoYjrD7OQFXOhrUjY
X-Gm-Message-State: AOJu0YzJcQjXBuGQZUXl9l7snaNInYj7oa0ygypxCVBLrkBliLwaPEkP
	nRyRh4n0CbfGX5ByHeLQRabYXEUi1aM1gNuLvRVFyokhU/lZqLmk8liCVDUjR9U=
X-Google-Smtp-Source: AGHT+IFDpjGxbjE1yj2KaQhJtnTzZWL6+zm6itz1Q5fudeNujgBXsOq2XLy3QruSXpvSAkpsEQdWlw==
X-Received: by 2002:a05:600c:45cd:b0:421:7eff:efb8 with SMTP id 5b1f17b1804b1-423056e01dbmr100092885e9.31.1718705413279;
        Tue, 18 Jun 2024 03:10:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874de607sm222957765e9.34.2024.06.18.03.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 03:10:12 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:10:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: linux-scsi@vger.kernel.org
Cc: open-iscsi@googlegroups.com, netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org
Subject: [bug report] [SCSI] iscsi_transport: Add support to display CHAP
 list and delete CHAP entry
Message-ID: <a60ed02d-3191-4e9d-b296-0a961a81a66d@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi SCSI and netlink developers,

Commit 6260a5d22122 ("[SCSI] iscsi_transport: Add support to display
CHAP list and delete CHAP entry") from Feb 27, 2012 (linux-next),
leads to the following Smatch static checker warning:

	drivers/scsi/scsi_transport_iscsi.c:3340 iscsi_get_chap()
	warn: potential user controlled sizeof overflow 'ev->u.get_chap.num_entries * 524' '0-u32max * 524' type='uint'

drivers/scsi/scsi_transport_iscsi.c
    3319 static int
    3320 iscsi_get_chap(struct iscsi_transport *transport, struct nlmsghdr *nlh)
    3321 {
    3322         struct iscsi_uevent *ev = nlmsg_data(nlh);
    3323         struct Scsi_Host *shost = NULL;
    3324         struct iscsi_chap_rec *chap_rec;
    3325         struct iscsi_internal *priv;
    3326         struct sk_buff *skbchap;
    3327         struct nlmsghdr *nlhchap;
    3328         struct iscsi_uevent *evchap;
    3329         uint32_t chap_buf_size;
    3330         int len, err = 0;
    3331         char *buf;
    3332 
    3333         if (!transport->get_chap)
    3334                 return -EINVAL;
    3335 
    3336         priv = iscsi_if_transport_lookup(transport);
    3337         if (!priv)
    3338                 return -EINVAL;
    3339 
--> 3340         chap_buf_size = (ev->u.get_chap.num_entries * sizeof(*chap_rec));
    3341         len = nlmsg_total_size(sizeof(*ev) + chap_buf_size);

Smatch doesn't trust nlmsg_data().  ev->u.get_chap.num_entries and
chap_buf_size are both u32 types so it looks like this integer overflow
warning is valid.  On the other hand, hopefully, you trust your ISCSI
transport.

Then we pass the overflowed value to nlmsg_total_size() and do three
more integer overflows:

1) sizeof(*ev) + chap_buf_size
2) NLMSG_HDRLEN + payload
3) NLMSG_ALIGN()  (ALIGN macros wrap to zero)

So my solution was going to be use size_mul(ev->u.get_chap.num_entries,
sizeof(*chap_rec)) for the multiply.

I kind of want it to be a static checker error when code uses
size_add/mul() and saves the result to anything except unsigned long.
Or when code uses the result to do further math.  The problem with
this is that people like struct_size() and use it even when they know
the result can't overflow so this generates false positive warnings.

Also maybe we should harden nlmsg_total_size() against integer
overflows?

regards,
dan carpenter

    3342 
    3343         shost = scsi_host_lookup(ev->u.get_chap.host_no);
    3344         if (!shost) {
    3345                 printk(KERN_ERR "%s: failed. Could not find host no %u\n",
    3346                        __func__, ev->u.get_chap.host_no);
    3347                 return -ENODEV;
    3348         }
    3349 
    3350         do {
    3351                 int actual_size;
    3352 
    3353                 skbchap = alloc_skb(len, GFP_KERNEL);
    3354                 if (!skbchap) {
    3355                         printk(KERN_ERR "can not deliver chap: OOM\n");
    3356                         err = -ENOMEM;
    3357                         goto exit_get_chap;
    3358                 }
    3359 
    3360                 nlhchap = __nlmsg_put(skbchap, 0, 0, 0,
    3361                                       (len - sizeof(*nlhchap)), 0);



