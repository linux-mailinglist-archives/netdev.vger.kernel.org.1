Return-Path: <netdev+bounces-251696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBE9EiUzcGkSXAAAu9opvQ
	(envelope-from <netdev+bounces-251696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:00:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F04044F701
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 03:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70B93A25173
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2D230BB98;
	Wed, 21 Jan 2026 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="folMGCSg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639930B536
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960681; cv=none; b=FX70OfJrtChU6ePbs4gIntoCEwHUQd6iE/ZaWMhIrMWF9ixUXB257z5XKGoT4dQM+RDCx5ZmcIQIKxEZGRkH5/pIfu09p2eqFz0FrdKCHXi6jYFzLWhppcaSn/oGdjsVsDgq8LYzK+KsO3yrtD8dMu3m2W2ZmswcNFBlim5FGhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960681; c=relaxed/simple;
	bh=Pxl8sMs6RnaZ020SHVaxZGQaaNcg2Z3EVnSdYyrD6HI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAgd4re19M9Rx1Xi7+jL280wc7ATsfaqm0oQ5mfSHKrvdnJSUmhjlIOwrCZo5mX7icwdHDKgGtZ+/mlrYQqf4V2s5zcy9vBVI1MkWzjjvVAQ3+6rRtODA+EYqcTAQltbdZMqrJ/e6uZXBaQEdxz47c6s7rBZVzCK0UzVxGXQYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=folMGCSg; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f1fb91996so13676287c88.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768960672; x=1769565472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQpr8TPg4r3Vyfobt5ZfLaeRlSoR7RFvm2Ik+WOu2+o=;
        b=folMGCSgV5ZiNC3b/56fs6/wa6nzZKaa8bGRiL/puyTMxWiOfX9AEFGoOQfHXnthae
         sMhq9rMkisErluwk0t3M3ct/f37pQwoFXCr79piQZeK4K6F6nweWjvkfeAX7DaY8LNb2
         EmvllODTlFRPgT1bRaVahVqgbmAea/+hguDEPm321R1Qj7zlsRZhk3/XTPgWKdrSU3YI
         eKpXImLTpjjEIl56OXLgViddHgN97aoshQH+vHZDy3NjE7K02us6dZ8Oh0g1eykjIh2a
         PR609OQjsEGVG3Qh5S/MzE7B1HtptBj6cL+RL+L+ClnpbK5JiHQ3RlEGepQUvliKe1//
         AbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768960672; x=1769565472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XQpr8TPg4r3Vyfobt5ZfLaeRlSoR7RFvm2Ik+WOu2+o=;
        b=HXbq5+5XUmtWNeedMw8l7nYH6ic5qi0LSvFRg7XrXgA+z49b+aRSTmF/tAoPNHrjeV
         1gU9Iqc44tdZ6iq9IeDuWGL+D2t15i3zM8jHAPAalYOQ8b2WEY7xLWb7mgF/XT6+2glS
         iyOvNYO9lysZX7pQ62UjcAwZfD7BtwNEj4SwczFk6S4LPY0/qrv/D2Fq49F497XOTcfS
         P41+5pNlsj2u3N/g8xUva4NRHKw05FwMq6+CVh7xtNvqgzGXkrt7LIZW0Dvg5zbIHErB
         /24CQSp7mrzyEbOeX/AsP3b8oPYJEI1RMjPeYs02mZFDY3AD394u1+ODOmj5gfmLiafD
         E2sQ==
X-Gm-Message-State: AOJu0YxFAm0OQ71ymyXOCwoyiCR5sRzlBPTnL7SQgh7KSXJ/b9WMYPym
	//jQ/WIPPXwHTX9OxjW0ArJ2jLr+CtHubL5ctNMn6IYXPzUMZMBgUfeqemJsPNllYcg=
X-Gm-Gg: AZuq6aLiKQg99AWwH9m2WjnIE8IT8gzik423aoWyVSy4B4iZM4YiOneqcWDeyYl3yiY
	AwsVVNiPqrzPuj3eSLpFANsWvDtAzTpmSs9Hh1OCzANSX4NpJLptX+pTWCslAer14qYHp3TWJAR
	jo2aKflkC3wGsV6Wghio4nvEzu6qYTyfCl+5VeFuouyMdWZ0chkDiXkwIm3vAWtzxCzoE8PjNmy
	0Oam+jUyAaaf6/042kuw5l4L7K52Q1PBhF7H+5swRoRTR1jDbj3VKJ8KfZf5MWgVNmqhnRa2dmk
	32jrQ8J3lXfyJbUolq8S++0oebgvlCJwROR6XctiM1ZHU9QtxuSNZ6yMNxCRzIzl+PtnM6axDvt
	GX2jqeaxYKzVVUVRniO+j4yp2pwF7SqwfqNoK4kDWi3FsSfQDymPXaIK/O9Oq1FH6zPyA1OGMYg
	7Oirk3bd/j4tjwz3RbAUJNA7+t3Zaxx28kcVN/l7vfuJf1KSGhwkZEB53txa1pIfMP2kOaPXezB
	geMC5rZJtFj
X-Received: by 2002:a05:7022:7a7:b0:11b:9386:a3be with SMTP id a92af1059eb24-1244b3822femr12385044c88.41.1768960672335;
        Tue, 20 Jan 2026 17:57:52 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::3:eaee])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ad7201fsm23132514c88.7.2026.01.20.17.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 17:57:52 -0800 (PST)
Message-ID: <6040a96c-514d-45e5-8970-5c0f524d4a82@davidwei.uk>
Date: Tue, 20 Jan 2026 17:57:50 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-16-daniel@iogearbox.net>
 <20260120175115.12c9735f@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120175115.12c9735f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251696-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,davidwei-uk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: F04044F701
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-01-20 17:51, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 09:26:02 +0100 Daniel Borkmann wrote:
>> +    def _lease_queues(self):
>> +        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
>> +        channels = channels['combined-count']
>> +        if channels < 2:
>> +            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
>> +
>> +        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
>> +        self._rx_rings = rings['rx']
>> +        self._hds_thresh = rings.get('hds-thresh', 0)
>> +        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
>> +                            'tcp-data-split': 'enabled',
>> +                            'hds-thresh': 0,
>> +                            'rx': 64})
>> +        self.src_queue = channels - 1
>> +        bind_result = self.netdevnl.queue_create(
>> +            {
>> +                "ifindex": self.nk_guest_ifindex,
>> +                "type": "rx",
>> +                "lease": {
>> +                    "ifindex": self.ifindex,
>> +                    "queue": {"id": self.src_queue, "type": "rx"},
>> +                },
>> +            }
>> +        )
>> +        self.nk_queue = bind_result['id']
>> +        self._leased = True
> 
> No frameworks, please, this belongs in the test itself.

The timing of this is challenging. It has to be done after creating the
netns/netkit, but before moving one of the netkits into the netns.

I could make this a functor that a test caller passes in. Would you be
okay with that?

