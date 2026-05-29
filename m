Return-Path: <netdev+bounces-293026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEduH2RCGWqauAgAu9opvQ
	(envelope-from <netdev+bounces-293026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:38:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A675FEA53
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBC1F308D23E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813F3B27D8;
	Fri, 29 May 2026 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DgT3eAyQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUlNJ1Tm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C1B3B19AA
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040140; cv=none; b=H7BrW7htQVntyDkaUjhRkiICy4UdYhMyCBMB8h1x1NBG8waD0+72/VphYfdoZ7zwrfchaU8umkDr+uolMkYuTMv83ICq+VQ9dm6okfG76XhPtISv+o7E067i0NIHquVwcZwdgYyLVd8WnHM7jUsWqiiz9salTDpoOExh7kEH6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040140; c=relaxed/simple;
	bh=S0Gw/6vAjouVLSqwBt7EnwCvtBf70xRCtFoUQO/ogGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IqIYbBxKYDLNiKk1Cw2tw0qYNj86PMOGdtV4S7NsBUP5RkowoBzNXB2C1tqai6zY1b0KrWUtEUMh+8nFXjUsFo7jpnkugUh0l3uyZFijzkAtjUDFEAAjfC33r+fZGVKoDQyJrIcHgT1QHOrXcKSA8dBCiDz+J7KRglEUbXXwAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DgT3eAyQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUlNJ1Tm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780040137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
	b=DgT3eAyQlQKqARcsSyEh7XUxam7YycTvYr03Vu2CuZCOYHplThnNZP/IxNIRTLkBqBAyy7
	gHTeJMCEunM/pkPLAKk00AZ/vgjfjCpwlR3godV9yX4siAa80n/5rPlBvc6YYErhpggaqz
	J1bavBqZkBrGKWtX+CEPrcUsM3e9koE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-O58rclPkNKuF1yASht2iig-1; Fri, 29 May 2026 03:35:28 -0400
X-MC-Unique: O58rclPkNKuF1yASht2iig-1
X-Mimecast-MFC-AGG-ID: O58rclPkNKuF1yASht2iig_1780040122
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48d127eb013so65590985e9.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780040122; x=1780644922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
        b=CUlNJ1Tm5/BGSlZGCc58cf2EXl2WXXI50WXWCC02rh3G3O+pT/aNtX5o90KsuvVfE6
         BhZ6+qpUIILESCsugZ5hhV/wdZixBsRf+7JYveRTvoWYqmJh+Mh7DvgDnKoA+h9VtlAj
         TbIUcXhoE7/3WgeCKwA4c3d5x+yCPNmS0CJiva8E/9uNjLtjcP6RgvvowAsLdK89gUMp
         +Qdq8+08m0cwX1cAt5ttogG2ey47FY78hCF8tYrmy9uJdFmzqu9VK3M+/hzB4jiIvodP
         7Di+gL7VqCM0l0D3t/lgb40p0jjyYo7ZdGsS/trDY+a/hJfzKezJQQlC2S4FMdkK8dbW
         Ny9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040122; x=1780644922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
        b=Lq2ZxahYFXzs4WOgOhMgs6SCnb7+dkFPGAm5Mfrg+A4IeJ24vkTWcgsggjPPDdAZVx
         9QVi4WsIkOiAvzahBGTSNWH6w78/oaSS40cQ2vVKwdon+Lvsc0tv4BcGOUaHroSLdR+G
         ofXGD4x98gCfb1StMMZ+UOBHSpjF5Mmxx+/xtaGQz08FM1W4m6XXrbHO0mIHSLyXtMfm
         Q6gVBSVWUijrjDtrrg6f/lZMp4rdsLFNf/29LDlMOC1OP6l8rWRZLKzaGisa7MCv/SEg
         UXF08nyI8cexsKgkhc49drHd3rO1wvm5e4zTVeQfOZs54NeZ8HcOgdcmm1z2H0k1wwPY
         op8g==
X-Forwarded-Encrypted: i=1; AFNElJ/3jl0wV4wjmTdvT4RhEq2eJVozTp4ZymMfX9vvdaK7AnAUeDoUKIV7wIMThX1D6y5lum2EV00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrUpTQLQGvdH9hfTFCumLPzQqV+a1wRYlSp/C5CcU+4aEi1pl
	YrSbN0lVMOuoeWwfnFFr67SQApFTT0fqxxg4ij9mA+Jzxj3P/u+LD5uA9UcgpkGlCJCco9HVt6B
	Cnd/YvO2g8Ay7x4GTcfH/7bDpkYZbKdsuvA6bsH0NX1G1SqCbx+rxVuS1suAp6OC7bw==
X-Gm-Gg: Acq92OEbHGpQroyZmGYn5mJnc1BxsEe+2xIQuCWSLQnqi7HnM4O8ueA30qH61V9yDqk
	qjLZIbMLPHGaJjF9pScC3ArUXeszhTYDdxaSej5rHvFywkCjUcRmU9HKmnlSKUPokiv1oaE6bCP
	yrrqzFQHbYsE7hVhguN5b5uiwxwKreBv1VgL06h0//nAPsurzR3uuWbE1sPuxSKbCVntAjl2BQ2
	Xjv6da+su0QNTnyzIS/RmINl1qZ6MPjL5J/sPEIQHDQJSaMcywSHppvwx6Kp1VdjYvBUDcCE2JL
	gDtS9vQuuLH6pGobFiXjdqZS5JQGjz9aWkxRaUeCgrpkdFFrlJ2Ifhjino00jeeO0XSEEzoslNR
	r2spOGmVpo0mwNNw2K2ddUZ81p9iKqIFRiaoGuSvclGbIwhfxPfgNDXDHsNvJk35iRK0=
X-Received: by 2002:a05:600c:3504:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-4909c0b4ef9mr28617765e9.22.1780040121953;
        Fri, 29 May 2026 00:35:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3504:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-4909c0b4ef9mr28617235e9.22.1780040121386;
        Fri, 29 May 2026 00:35:21 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0e42sm20813525e9.8.2026.05.29.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 00:35:20 -0700 (PDT)
Message-ID: <de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com>
Date: Fri, 29 May 2026 09:35:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
 <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
 <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293026-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 26A675FEA53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 6:10 PM, Luiz Augusto von Dentz wrote:
> On Thu, May 28, 2026 at 11:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/28/26 3:18 PM, Luiz Augusto von Dentz wrote:
>>> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
>>>
>>>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
>>>
>>> for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:
>>>
>>>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
>>>
>>> ----------------------------------------------------------------
>>> bluetooth pull request for net:
>>>
>>>  - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
>>>  - hci_conn: Fix memory leak in hci_le_big_terminate()
>>>  - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
>>>  - hci_sync: Reset device counters in hci_dev_close_sync()
>>>  - hci_sync: fix UAF in hci_le_create_cis_sync
>>>  - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
>>>  - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
>>>  - L2CAP: use chan timer to close channels in cleanup_listen()
>>>  - L2CAP: clear chan->ident on ECRED reconfiguration success
>>>  - ISO: fix UAF in iso_recv_frame
>>>  - ISO: serialize iso_sock_clear_timer with socket lock
>>>  - HIDP: fix missing length checks in hidp_input_report()
>>>  - 6lowpan: check skb_clone() return value in send_mcast_pkt()
>>>  - btusb: Allow firmware re-download when version matches
>>>  - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
>>
>> I'm sorry, it did not fit today's net PR; I started cooking it quite a
>> bit earlier than this one, and I looked back at the ML only after
>> completion.
> 
> Well I guess it will need to be merged for the next PR. That said, I
> wonder if I need to submit it one day earlier since there is a risk it
> doesn't get merged immediately, causing us to miss a week of the RC
> cycle. Maybe due to high influx of AI/Security patches we will need to
> submit it twice a week or something.

Indeed the AI generated load is impacting our workflow in many ways.
Among other things, our patch processing latency is roughly doubled
according to my complete wild guess. I agree posting the BT PR 1 day
earlier would be better.

Even multiple PRs per week makes sense to me, if the average size is
still significant. I'm not sure about others maintainers opinion, please
don't take my last statement as "a please go ahead with this" before
more acks.

Thanks,

Paolo


