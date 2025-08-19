Return-Path: <netdev+bounces-214972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B974B2C5E4
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC0B1B62794
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3333A018;
	Tue, 19 Aug 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c3bSKufj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED458338F58
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610619; cv=none; b=IIYTZB2L0Vb81Px4z50aZmPT1ckbU6Fk8M4Z0krfV7va2nwj3RWQRFnxSIRAgJ1LPujiqIIoxrlN1DOHuP7+A3ltIwJFALVEMF0LqnDZbJg7ymJPawfGsMBBLxh3bKBhnpoXkVBZQdreWQsYAHoiJtQAKA/UHzu+7ScH5uhfoSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610619; c=relaxed/simple;
	bh=ses7cvDAgeLlulpRb7LhAvFTG6yY721+EVGzVkEhouY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hG/Na4LGBhFpY+QvneTAaoJUpxyhwCQvlyuyt+DRR8jtcjJ4TODsnmuNG2tyZvM4MXcRUV4yUvt89e3n9+0JW+zX9P32aqZcSwlIGq84uySzcNd87tyzE1DCx/fqBpL0iOErn5qBllZPdPbkX3/a+HrQ3Phy4JQITha4M/bKGSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c3bSKufj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755610617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ug3+QB1kigmLvHdV+5tcNTutNLJ6/dvktxgLZPmeoKI=;
	b=c3bSKufjSRc1cMnsFl56PP7QYLyAcDxMBWbIzGk8QY2gpfg6FJUy7RNYsu8KUpn4g/de5W
	VFliPg739lOMhOx+rtw3zzdmcpgkCcQK8PxVcCPKBelRI6czzlHfP1AeqSEzK5PjocYSav
	mVFvTamLlCV14n+yOjFX/RAzUHfRrHw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283--JmeY1egP7u4HMm83Y2ZIQ-1; Tue, 19 Aug 2025 09:36:55 -0400
X-MC-Unique: -JmeY1egP7u4HMm83Y2ZIQ-1
X-Mimecast-MFC-AGG-ID: -JmeY1egP7u4HMm83Y2ZIQ_1755610615
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b28434045aso42435681cf.2
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 06:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610615; x=1756215415;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ug3+QB1kigmLvHdV+5tcNTutNLJ6/dvktxgLZPmeoKI=;
        b=sg/Y2FCOdemAY0R5kY1Caa7dX7sXT/X5rJXQc39Er5xRZMZrkdqTAw195A/y9ccQHy
         xCTPP8u0+IcVagcHdt7xils7ZSntJQZliCHY36QXZ7s1Mry82skWPFO49Jtm1Y78fSHJ
         wLF3mozhS+VBu/MGnEcJ2uJRB8VvVgfQThmswr1mkNOaESdQB9n29K0AfkZlSnidNYEq
         4NBcjMrwV8nal2txAimy5wJsmt+7LtN20CCxkDZwJMMURR9A6PJsoLTBVJWjtY+8cHR3
         Irbhk97ijrzLabLBfqn3ULBV3LOeF7gvffC2owJma+HIoW+voLp5Hu65PlS9qS0K7Pkt
         xa9A==
X-Gm-Message-State: AOJu0YwasXuSEV4kj8+amAgUiezNEBUyw2rkCetXqfwxQblV46zlQRmJ
	51T6GokYsGaiXyWrZZJSv+YmbLNxSPXcUBT9eFDPapzHcLJDOmWsJGsQu6FfdgejqndaIKVhUdE
	HlP6djVL/wL8WIaIVxNKiN/FCXORZBWmUjvibXfdNvDkZfGFFU+gBer7aMA==
X-Gm-Gg: ASbGncu48yrlAlKWpTWaO8mDWRlhN1rPyldKBr1JIr9MvnRr6GFOF3XUzXP9JO4hMIW
	YZHBpxVaJWMuSIZ2U4fHTCzhbybQJRLLvLucrA+RfuX4VBzW426N5yId3mCnoJ71Kl25dKagjNF
	UBwozkkQmc/iCOi662GDNTGu5NJuGZdMRuVxEaZYVVQms935zp9fgANon5JARbEQ8LxeaeMy5Y+
	wuHLEPDifcKaij+8SCEKbM6KMeONmGAVXwE3tiDxotHyt8GawrIrCnVVcO94SwwcLIs/lj3/2Lu
	i0Ql3ZZA3beGGv9M/bWMfWkgST5gQ3Xsd+Pow5p7/60OTS/q2ZgwYMhAxq2P2mGx0qtk/dhUEeC
	OvNp/EbUeFe4=
X-Received: by 2002:a05:622a:4116:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b286e18a44mr29730651cf.33.1755610614747;
        Tue, 19 Aug 2025 06:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcuikD+z1aBhWawTZB4Y8+HlULz2fYWJ/MqafPQ1f5iBf4eDR77H0oczmovLBnl4sHDv/v/Q==
X-Received: by 2002:a05:622a:4116:b0:4b0:75ed:bbf9 with SMTP id d75a77b69052e-4b286e18a44mr29730101cf.33.1755610614332;
        Tue, 19 Aug 2025 06:36:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11de50e05sm66687671cf.53.2025.08.19.06.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:36:53 -0700 (PDT)
Message-ID: <37c9e5fe-e4c4-45f5-aae9-e949cfdc8902@redhat.com>
Date: Tue, 19 Aug 2025 15:36:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 6/8] hinic3: Mailbox framework
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <helgaas@kernel.org>,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Fu Guiming <fuguiming@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>,
 Lee Trager <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1755176101.git.zhuyikai1@h-partners.com>
 <0b7c811da62813e757ac5261c336a9b7980c53a6.1755176101.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <0b7c811da62813e757ac5261c336a9b7980c53a6.1755176101.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/25 3:02 AM, Fan Gong wrote:
> +int hinic3_init_mbox(struct hinic3_hwdev *hwdev)
> +{
> +	struct hinic3_mbox *mbox;
> +	int err;
> +
> +	mbox = kzalloc(sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +
> +	err = hinic3_mbox_pre_init(hwdev, mbox);
> +	if (err)
> +		return err;

Given that all the other error paths resort to the usual goto statement,
this error handling is confusing (even there are no leak as
hinic3_mbox_pre_init() frees 'mbox' on error). Please use 'goto
err_kfree' here...

> +
> +	err = init_mgmt_msg_channel(mbox);
> +	if (err)
> +		goto err_destroy_workqueue;
> +
> +	err = hinic3_init_func_mbox_msg_channel(hwdev);
> +	if (err)
> +		goto err_uninit_mgmt_msg_ch;
> +
> +	err = alloc_mbox_wb_status(mbox);
> +	if (err) {
> +		dev_err(hwdev->dev, "Failed to alloc mbox write back status\n");
> +		goto err_uninit_func_mbox_msg_ch;
> +	}
> +
> +	prepare_send_mbox(mbox);
> +
> +	return 0;
> +
> +err_uninit_func_mbox_msg_ch:
> +	hinic3_uninit_func_mbox_msg_channel(hwdev);
> +
> +err_uninit_mgmt_msg_ch:
> +	uninit_mgmt_msg_channel(mbox);
> +
> +err_destroy_workqueue:
> +	destroy_workqueue(mbox->workq);

err_kfree:
> +	kfree(mbox);
> +
> +	return err;
> +}

And you can remove the kfree call from hinic3_mbox_pre_init().

/P


