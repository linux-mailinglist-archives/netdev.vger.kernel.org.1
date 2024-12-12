Return-Path: <netdev+bounces-151360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F14C9EE605
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3CE2862CC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC541DDA14;
	Thu, 12 Dec 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoMICHdr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6281F37CC
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004564; cv=none; b=bf/DH3aQdzXG8BYHhVr1ogj6jj/9ehApFUMu9f5Q4drzvxmDI7G6c/PMAI3bRwxZgeNDAu/e0+Z5JQuAMq+1CXAx0/6wAk0ZMYTDBu2tqqoWgbPPxbnBzAUvAzJ64wlAos4vDxKDU+R9iuiQcOvTQutbGDx0Cti7i+oJAcbD/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004564; c=relaxed/simple;
	bh=2nF4sMbNNcAbjh6M6CI4/V5hj1XPKTswrGt6J91nTus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLk13p3UcNKk7eA5daV4oSdWvwFqXIDQmeRus4EypP2mmClD60RDALaINciC7gTA7vr/wI48n6+duzfxAFQEKwqjJwJ1t/20IfrpteR2fTxp2O/DRsVTrS2R8a8y6+aYqb9q8ezqiAzKN7NlaH3VQZwrvH4KS7AEuGsEZhLz9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoMICHdr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734004561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3euoebI4IXSCrPQSncwT3g7j7yaCMbga1TfcWV4sQzs=;
	b=QoMICHdrrV/gwbDIOAv9fHevt7SxwbRzoBeZllMY0Iv/bZKXq2hsjXeUfwxqZNIvLtUnVl
	HlAWokDrdTEZeMbMH6hEh/iBCauE/fn+oVO3nNeWccEKRNY3mWyaH1hThb7ua5sdwc/+iZ
	la9MWFQGCBiuXToFME5WAqnOgHFDz2w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-uxzQKJctP8mHnzevdayNbQ-1; Thu, 12 Dec 2024 06:55:59 -0500
X-MC-Unique: uxzQKJctP8mHnzevdayNbQ-1
X-Mimecast-MFC-AGG-ID: uxzQKJctP8mHnzevdayNbQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e9c698e7so297518f8f.0
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 03:55:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734004558; x=1734609358;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3euoebI4IXSCrPQSncwT3g7j7yaCMbga1TfcWV4sQzs=;
        b=Zoi9YmTwnV0LBfqPDckGwY2LoEwz3bEEarpJ0e/WhHzzgrKveRwE3swUqCbwnhFFmu
         X+8XcfXeSNzOpq+6MmzRKOKywvFrRmk4bJY2uNuQtxch6LXLoUNH8EdeI9U7VXP+ep7B
         ob6ibHqQk3yrxM8f5wn5BC7iXs3n3AA2Cud5BBy6v/qcPj7u71pNCC3Owv+5uydzvDF5
         oQ0HO/EGoG+UqbDzJijCkQlconqqA0awUHk1Wos4+nLY8wlYPdBSgHyXajg4Pk1rljqh
         tu9+iWu2hU/n6sB8CsSM5FrtOX28yiOmgSw3sJue5j/2je2h3yFkiTrT8mfSRHuCo7j8
         8kmA==
X-Forwarded-Encrypted: i=1; AJvYcCXXu/Gn2eqAzQljVyzv7JN+9BP3HGTk7IzzSmwK1TQDqLhP452aed8C2TIhlU3jWABZdj0d/yU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmGYt2hzMEi/8M/QLMY7/kVpp19ChnCCSHNjysBqadlU8oqXM
	6Rh/tnHL4POQ1XVuDV0uJLucymtjnmBTjtwdnbEjDbUqd/YMRllEe/Mywx8gT4x8BG2BwfxBXGH
	BH2OWxMRGqRSleIqjFt14UPZowU4PaG4BoiNSsE315t4VVRa2fJ6PWB8Ys6JkCQ34
X-Gm-Gg: ASbGncv/YpeIbW3Tyol4IeQmQpibpVyglJXycUpIvoUr/BR1SOsePO4+aYpO+ElBTrr
	nMi8o2JDL0ximuS/MMVUWQ42s+DQGQNLO7pd+aRlHS1dBDyzOMF0EfPs246bwiZqi48VlvfKrZi
	YC2EJUmZvnRgcoTpwBXXkherZG95powx8SyKlW4Amj9HSqSC8uo2gtbCm12+1iZ6S8naEmipDpw
	TckT4wB/D1wB5KszmX5evNeg/iTasN4sX9qRCgpmkQ2bp48w8ZSS38qYktIDm3XGtPhcD7ARDYL
	/rXhFwQ=
X-Received: by 2002:a5d:59ae:0:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-387888628d6mr2044445f8f.25.1734004558330;
        Thu, 12 Dec 2024 03:55:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcPhZnYsOjIwfm7ByMsW6dzEWzI5foPYWVqg+0x2zxmXyXth64gr4How96aoMJjPfh8zMifg==
X-Received: by 2002:a5d:59ae:0:b0:386:4244:15c7 with SMTP id ffacd0b85a97d-387888628d6mr2044432f8f.25.1734004558004;
        Thu, 12 Dec 2024 03:55:58 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ef66sm14560265e9.25.2024.12.12.03.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:55:56 -0800 (PST)
Message-ID: <ba32a8c5-3d90-437e-a4bc-a67304230f79@redhat.com>
Date: Thu, 12 Dec 2024 12:55:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: pull request: bluetooth 2024-12-11
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20241211172115.1816733-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211172115.1816733-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 18:21, Luiz Augusto von Dentz wrote:
> The following changes since commit 3dd002f20098b9569f8fd7f8703f364571e2e975:
> 
>   net: renesas: rswitch: handle stop vs interrupt race (2024-12-10 19:08:00 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-12-11
> 
> for you to fetch changes up to 69e8a8410d7bcd3636091b5915a939b9972f99f1:
> 
>   Bluetooth: btmtk: avoid UAF in btmtk_process_coredump (2024-12-11 12:01:13 -0500)

On top of this I see a new build warning:

net/bluetooth/hci_core.c:60:1: warning: symbol 'hci_cb_list_lock' was
not declared. Should it be static?

Would you mind fixing that and re-sending? We are still on time for
tomorrow 'net' PR.

Thanks,

Paolo


