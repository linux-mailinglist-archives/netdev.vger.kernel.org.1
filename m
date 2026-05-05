Return-Path: <netdev+bounces-284567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFxFC/lC+mlJLgMAu9opvQ
	(envelope-from <netdev+bounces-284567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:20:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 858B24D3128
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 21:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23552303C4FC
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15BC3CF685;
	Tue,  5 May 2026 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="H+mWYVdd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F330F816
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778008822; cv=none; b=iRE2jQCXlOcPk+/jJ0DYWE0K2/y3ZGtAM55J+uQE7d5h5ubYWp8z8GRILfJA4FoZpqWi28+iXrZwTOeZPLaU54QNWptTxGgSG+G9tBbXNy44LF5H2gx6NmLy8iwFNLaQ5Ygq4jt3eFRViuQOBFCQF7S5yQEvuIXIHMcPo68IWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778008822; c=relaxed/simple;
	bh=1Qwi0af4BH6IkT3YJ+ZsYrbcpFt9i8xrRjxJe9RkfKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DY8KQUR1cCkOkKND18brLhU1SpmLqvtfJvQt+GWJuNVbGeMKY4xrJ+NP7gsuKiFQzAC0iHfvzU5kTyAO17ggQhpNLZf6WSaNOV7c4peCf+SDgS8Zd7pvw62FInS7G0Fheou2LVvBMHRJ51YmsK9EH+xId+wbOqCTx9+RZA4FWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=H+mWYVdd; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cbc593a67aso499303685a.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1778008820; x=1778613620; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d+p+m5LyLcdSJgnUuUV0CVhwhDpBiPQanJlO5X06IFI=;
        b=H+mWYVddPSRmQwHKE8xqtSqHaQx0O3vyd/ZlLkQ1x5h8GUhVv1LXSW5iihKzzBDMGz
         Y2s4eIODerWr9umZKNZHIdnAQw1HGmTLw/ZKZHXqhDz+RGRZO7lbFCmJDaAYR8hf6KZi
         ooVO76zaBrBV5ErIOEH4pnejWzwW01ia+u/GWMDlVncCi6IEmVmjuGQ0v4P3qc1bEYm6
         hNsOdM0wESiHk60fOVDDH9QR8MRMm/u3cRCh6AQuIlObqWaiUkRVtOaKR+x2vG+OgZNK
         PW/RC8aPbNCUlBjkJCudOhdXfhBbS7SNkhUXhnAQS77qibfJmMy/lRLhABOomenxTONN
         H9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778008820; x=1778613620;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+p+m5LyLcdSJgnUuUV0CVhwhDpBiPQanJlO5X06IFI=;
        b=o6rNp9oinzWBHGSj0eUUI8B0YVwR7P731a1iSnqgSk0rqYbX4RaR6hRbKPlLqIVMfN
         SYoMCvKziZI+eLzrMUjrF7vq0DAvzMuI8r9QhB79aCZC04Q2cgZ4nM+VlfAsWeutxdNw
         wv1d9NFz9+jpbesgkTAYkLdQvpkw4uzo4LFusmfaGIg2XY/xnKcrOjCRqqcRHrZPFM9d
         tOVNmtYxofM5MpXqeJIz2mlxMzQC5qwPiOCmlD5b6YXWljdnPKmee6bc5KZn0x8VGVBe
         hq4S9ARSWoaMKpz4kF11yL9vokb+K6RPgj3YKDNYlA1N1WPdtqkyeAhRkEEtMunAVdBw
         cWBg==
X-Gm-Message-State: AOJu0Yxzjh2iqA/8oPnKW5DUZkilhCjX5N6M7cS+OuONQiYhw5k3dA2e
	VoG+rGDaF79kAxoe18ZSJXlEG0CmQdX31n2BddRHuvQ40Hu0CUjgMSrY3G4jTdUVmo0r3VoYrms
	Z3H3NOqvrSOsaL1VV6K6k9ps130/3QZVY917nevbZpga9Be1Btem1WJdfkIYzsZHrEq0=
X-Gm-Gg: AeBDieshjN5RbbeqatLePF6cBODpOCxzte8w9/CCIQC1u5BXKLpJr7NOj/hqQkc1gVs
	VkJs1GLFwYmL1kl2zqa9teOf6NIeg3IIASO87fA+/46lsI9+fH3UMLlNoAiV2gDKLyfIllUgNJL
	wdP/7gWl/18oVgnPoJkFnFNGHL7yjydkmRxPy4xS0iLP+9sDT0qC8/jzlxmSjkeCyW759DDt8KV
	LKJsc2uX2OCFSbOI8mgQEklz8TvbwrZsA1A88+LECMeYevLCdQRVAkpULx7vpAib5/R+HK6J6oq
	il/6ifnz/QRYwGsq3txSmruuS1trokeJjWVzjGPwfEyUbXG9/fCbMxudVoFmSdRN3k0wwVvO0u9
	JVLD/Tc9403XtAnBx6mfBr+uqPwt7GBo93mKUKhjeFmP//rMiAP/+SFhfabCiRFx8hm7R76MRPv
	3vwePfl1Gsm9L74EsigXZ9vHCAjIcyZOSTszz90IAziXwAq9z5nvhoHjTdLBuV7Hs20crZPJiA
X-Received: by 2002:a05:620a:2699:b0:8fb:1acb:c907 with SMTP id af79cd13be357-904d3cb86a1mr63368885a.12.1778008819735;
        Tue, 05 May 2026 12:20:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:39a8:9413:9de0:76ef? ([2001:67c:2fbc:1:39a8:9413:9de0:76ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2938e7f8sm1419381985a.7.2026.05.05.12.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 12:20:19 -0700 (PDT)
Message-ID: <92b24c57-ccc6-45db-99db-31596ba3f5d3@openvpn.net>
Date: Tue, 5 May 2026 21:20:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net] ovpn: fix race between deleting interface and adding
 new peer
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: ralf@mandelbit.com, Hyunwoo Kim <imv4bel@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20260504142033.2327646-1-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260504142033.2327646-1-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 858B24D3128
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mandelbit.com,gmail.com,queasysnail.net];
	TAGGED_FROM(0.00)[bounces-284567-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]

On 04/05/2026 16:20, Antonio Quartulli wrote:
> This patch is sent as RFC to give the AI a chance to review it once
> again, since it was able to spot a new race condition in its
> previous version.

So we got a "critical" report from sashiko-gemini.

The AI analyzed what happens along the error path, by backtracking all 
callers and checking for potential problems.

It found a potential UAF due to a worker not being disabled when 
free'ing the peer in this early stage.

The analysis seems sound and I will deepen it.

However, this bug is not introduced by this patch.
It just happened that sashiko investigated the error path due to this 
patch introducing a "return -ENODEV".
But the problem existed before because we have other spots where an 
error can be returned.

For this reason this patch now seems to be ok and to cover all issues we 
have found so far.

Once my outstanding PR for net is merged, I will send a new one with 
this fix (and maybe the UAF fix too).


Thanks a lot.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


