Return-Path: <netdev+bounces-263878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP1yCbFUqGlutQAAu9opvQ
	(envelope-from <netdev+bounces-263878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:50:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B6C203496
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0298131CEC79
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFD03976B1;
	Wed,  4 Mar 2026 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gfix+b74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B179A390205
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772638543; cv=none; b=PWtcgHmvjaXLIIY4+70usqwCdmxaX+rktS7+DYOX3HyZVwomQWbp49EA+oXUAYLX4CZOU1Zk0b4ujjuVWhafgYfBNIra52uss+1YLxjHvQkczVLjA57XrPhJhUHxuMBylSBy/QPMq23DjSLdhvktxuemfuviA09FD42VaeoK8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772638543; c=relaxed/simple;
	bh=tIMu771eti/7wiXo4Au6giCwBRYWMVsndvF+yY6uasc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k3s57TtwsXffzlKFv0r3A/DH45gB1y6Epp8Gd/cdsLyDQbs9iXtjOy3waygTJyRs8AgDYFLswnOfbKtVxPTY+2cFK/UlK+mEzOorEzpZKTA7VUDuHckRyxms6BdeC7kPLwZDgBTR2Wx7is5EP1JtIXNdO8BdT8F0v41ABingFxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gfix+b74; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9a9be502so46828455ad.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 07:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772638541; x=1773243341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsY5todpbk3rMcwCwi+T3uOMFloUvB58xV7DNnWbYXQ=;
        b=Gfix+b746z5kupUDEAkxsIFumSFtKCo9Mb13RzzJa4RtMA+82Fdzp0vs1ifEJbhahO
         K3uvGgI5HsecZPg6L03FZK6UG8pJphyl7Ia2SwyiNImrnZYQtG7FB1KqwCZ+0tfVgcKR
         bp+HNLevynra9G/xrxGOsoclXSrl/hwl9j+BSku85TBFa9arEWqbjpIRgfklHGRNpYg1
         8qewp6FluMbtctaU62t7HvtjbJUu/o9D852wtL4aVxt96lXspZjqL00Hh4nYH4qi5x7p
         jrtE7Olrd1DotrZ1QzJobqb1VRmhmrdY0DfxBOLAg9MO52nyI+c8CqiNiLoRfq/8hZqA
         mcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772638541; x=1773243341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsY5todpbk3rMcwCwi+T3uOMFloUvB58xV7DNnWbYXQ=;
        b=iw0eT593BnIoIdaZwyT2oLgKejpDn6FSsSy8XJjm5ps86nKl6LkAIFaFBwHyGM02db
         Y+fzaVjHsakdcXvwR9d7rWCnTH/j0V05+Fmk++gOa7bOUagcc1+nB6lPljEAaELNDkGu
         7Q6Y8+MT5WjcPW1uDLNIA7P+oYfI56Nucx2Exi4nbeVpMknfW0GNl1LukHlpDn3Hl1RG
         EOxOyCZVia8rl/MgW8fZQrmW0kmMYq8qmZ//IkXkhAVWeu92t9PGSHKUvmzr2JUPS6Do
         TOcev6r2pY7DdTGE2j53TC5Gtwk1c3w6bHve1Xvf8vJLm6hNIKXdtI/6ZSX9Ywdj8bsb
         y6hA==
X-Gm-Message-State: AOJu0YwRn/tixNj40GZv87s2iUoMxUtdh4q3GYTS9KTDmG2aj+nR6V82
	/NXupZPjlRlXetLqEB5OwQ8fRrdg5kpktJ9nWxE3X+w9YIfenYPWx3EB
X-Gm-Gg: ATEYQzwJ8JHbpKikkDrq++Ll1finf532Fi9xKPXKw4RAOb+itzKvR50TIZETt0EJLP4
	HkiA0ahxb5HgoXzapVmjZjxgo0l6faBXk4ZAxC/pwBTcDL6zeDCuHmQPv2CodChE3DLvODt/G2X
	CTmBALfvQaHQoMc134Af8b3O9DN+Ko0TasIB3KLAdPRxmQUE/CBXACHhZs6thGnLfuTi6AdLl/U
	Fkop+FWQFhXA16hNgqsTvs4ZlCworJKJmDwPczL1NJVqIfC5SRLMsgh64SnsrWQ2eLCt50zM2fa
	m+27pfHwZTdpGIKZi9VgJIpB2J4kOPRyjMUp2UEvRViMUt5OnNOMaxBG8EAep7CZ5UXL7+Zsyaq
	89TZ9fAJxhA0Ri8A1ppSiaFvv7CncHmY3Jch0uQtBH/j2gvlqXkRRPRpwmLTywsOuhIO6JKzfDS
	1xM/TifaxXCqul0aHjOxYQ3ayvxsTB5tv9vz0LCBE7vve4VD0Gg5pDCUark53JN7Ueah3hKaD6e
	p2gtA==
X-Received: by 2002:a17:902:f541:b0:2ae:3a1e:3490 with SMTP id d9443c01a7336-2ae6ab10e95mr27956305ad.38.1772638540911;
        Wed, 04 Mar 2026 07:35:40 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d? ([2001:ee0:4f0f:b1d0:50db:9305:a4f4:d29d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6f0ff9sm214379215ad.84.2026.03.04.07.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 07:35:40 -0800 (PST)
Message-ID: <e3382903-3854-4479-bcb0-bd9793148b2f@gmail.com>
Date: Wed, 4 Mar 2026 22:35:34 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] virtio-net: xsk: Support wakeup on RX side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260302164158.4394-1-minhquangbui99@gmail.com>
 <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoAm8wBEes9unXrssHHsnPP28b0XcOdqQN-TVtet5O2sAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71B6C203496
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263878-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minhquangbui99@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/4/26 14:41, Jason Xing wrote:
> On Tue, Mar 3, 2026 at 1:03 AM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> Thanks for handling that problem. Please carry my tag in the next version:
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> You seem to have forgotten to add Xuan Zhuo's tag...

This version contains a bug fix which is a non-trivial change so I think 
it might not be the same as the version that he approved of.

Thanks,
Quang Minh.

