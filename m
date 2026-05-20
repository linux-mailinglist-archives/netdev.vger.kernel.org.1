Return-Path: <netdev+bounces-290066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC8sFC0EDmqs5QUAu9opvQ
	(envelope-from <netdev+bounces-290066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:57:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E227059779E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8DA932BBF32
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A873FF1B8;
	Wed, 20 May 2026 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ctTuXHwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C443FE660
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302767; cv=none; b=hQjqDCbYVVQUHjihdjcWMGTgki839NI2/Ki6aMFh6xayr3Lk8bzVVbEG7HbvH1DTP0eRaaork3EA0tOFYG8ayo6PRhqoE7SK+7sqaGyHhfvEUD4ejAejeXLjgIHCS/PV1tSC+K9v4V0AllmlBKMNp3/pDj8R1nI+RDc5J5UDpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302767; c=relaxed/simple;
	bh=IEgOhX5mSlGgMwF6CJs9QGBb5c//pY837CoFBbgWLjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgKvk0FHgbshhy9MyMIxciqRJFQcGrnk4bWyBVRaBR9r6XV9SsEsvJ/iyuJ/XQgDthZoQV8Miu+NuB8k4Uplef7oR9dmLnQC3d4WETTDafwMKyUYrctCxZvYK3h3TE+PNTdgCGnPP/too5u/Ouasxie0co0R7LOn9b7Sk3hYxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ctTuXHwj; arc=none smtp.client-ip=209.85.221.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-57746f02da7so3407537e0c.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779302762; x=1779907562;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yz8WNPTLivvf8aO0NCQc1Y4S+bsvggq3/xlwaBZWzOA=;
        b=MpM9rnniZcR3UJHtSr4ufAd1wt6iWFfjR++04d4u4O5qEumaN7RwBLXWClEOxdF9o2
         SGtW75Sz9wOZdGEqjvptC/MijqmvP2agRXxPXWJDHTOHxdv06Tvvnp0jD2bLQa+bViiQ
         vcPkx5XWuVB2MzePMOO4a9VLJqrBoiyJ9bfdIpbsxSHY/SeVmMHr9K4J9rak3DjXZVqW
         mWSHIAJhjMJiaC2aGzgKnyEWJyGpCGi7piA4uDFu173yUm+x+MH/RPlHi21uQbVGvwyN
         uOT2+tXHyoX5vW449I+qAmrre+TaG0ErpJ7+OrnK+47uyK42pNcU4Ctfz+YcZF+U6Li8
         pVoA==
X-Forwarded-Encrypted: i=1; AFNElJ8KWhsIqK3CbzDgqV0mVgxqOArzazumCszpJ1juKLhHKAD7VrhXgYdyPie+25iJb8mUCVSAX9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcNhWYIw30vqeZhisegBYXrlnVXxB3BBanuOz6TtNLhxlgt6u
	Fl9c8xafdU2nMT9hEjyepGOrjNJFgHwc2arNKlttdxHBDo/ksUzsa8ilW/isFYDyAPDWfUeKtbm
	2CiUA/IIahoHIhplDXTUIzzlKXwGK7DVAz8hUFlvxmm2geuzq2GyPk0Iekl2Z+XRnGavWDxsThg
	NNrcbVOKH+HQp48GgFEhTl13WQriQuSQxya01vOHStttnsV7cgR5hgqWStSkkHoRGGLdVEDCSKp
	S//wrwnkZ334CgF
X-Gm-Gg: Acq92OEhpzRNJ00d87dfJ+FWoP50nKZXY4vD80BYr1UPBxZz/DGuBSg3p+wESj1XBgK
	aifed365vf9IhxrAwtANsTDA57Uo8qlqrKma37wjnLLPYp3J3yqMdetCbqlu8/otZ47uE13QtEn
	eZXuvtdKI3kVkEFFxokXRs07L615ARRbha7Wu322NyOOKvqTsvYmA+CanYFz9Iq7q+fUAsmPTQ5
	iorzh1HwVCXwW7VxkDjlJGPkiBdI4/0JzkevpTSVPTP9Xoa9Uw7WDyZYc8iDdjE9Lh2W/Zn6+52
	lzHrtHF+PNOwi8nsiQa6CJWXKfKAF/zLDtPLc3wKxREjvvbcjPZ/Tj8CKuTNGCjFVxL1aVskgAB
	cDbSbUzr7wGJ7JUfgpABhrtkibLlP3qxnqe8Ec9GJS4HCI2FFpRo6lk1pMVUM6qGFbEcNd5JCnd
	X4afPnfyo3GqvDmKD2EkpXLlSkfKE9SqKFMwwqmkrlKDrlml25Ag7h5HpUw8pvpw==
X-Received: by 2002:a05:6122:4f9f:b0:56f:6add:9029 with SMTP id 71dfb90a1353d-5760be34e4amr15507013e0c.1.1779302762471;
        Wed, 20 May 2026 11:46:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5760f7b1612sm1444697e0c.4.2026.05.20.11.46.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2026 11:46:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f525565b33so6512249eec.0
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779302761; x=1779907561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yz8WNPTLivvf8aO0NCQc1Y4S+bsvggq3/xlwaBZWzOA=;
        b=ctTuXHwjiEwLHDYK0cmw9W7MsHzoHq4SxYuF5718RCg8h53xzdyt/KVbgW6a1kQcx6
         qGnfUo8n7YKn+WfJU2qFuQO4hc6sOoRfuNhG3mCJ6zX37xqMDW66iouGNWQSyxv10UQW
         9kBkPvCxjAYEoHl4REQvFEhY7EwVxv7taDxxM=
X-Forwarded-Encrypted: i=1; AFNElJ/HTBbOsiJXxkGiisoBHBikMv+kIHXi3VETI4JrWGX5Sl+MCTGOfQyEWcjPm9PQvAFiaIwwybo=@vger.kernel.org
X-Received: by 2002:a05:7300:5b88:b0:300:255:22cf with SMTP id 5a478bee46e88-30398652e7emr12183196eec.28.1779302761019;
        Wed, 20 May 2026 11:46:01 -0700 (PDT)
X-Received: by 2002:a05:7300:5b88:b0:300:255:22cf with SMTP id 5a478bee46e88-30398652e7emr12183176eec.28.1779302760431;
        Wed, 20 May 2026 11:46:00 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304052f79ecsm6188546eec.11.2026.05.20.11.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 11:45:59 -0700 (PDT)
Message-ID: <59df32fc-59eb-429e-aca1-2c5a64c988fc@broadcom.com>
Date: Wed, 20 May 2026 11:45:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bcmgenet: keep RBUF EEE/PM disabled
To: Nicolai Buchwitz <nb@tipi-net.de>, opendmb@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: justin.chen@broadcom.com, phil@raspberrypi.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260520184320.652053-1-nb@tipi-net.de>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260520184320.652053-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290066-lists,netdev=lfdr.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[tipi-net.de,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tipi-net.de:email,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[florian.fainelli@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E227059779E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 11:43, Nicolai Buchwitz wrote:
> Setting RBUF_EEE_EN | RBUF_PM_EN in RBUF_ENERGY_CTRL breaks the RX
> path on GENET hardware once MAC EEE becomes active. RX traffic stops
> flowing while the link stays up and the usual descriptor/RX error
> counters remain quiet. In that state the MAC still accepts frames
> (rbuf_ovflow_cnt keeps climbing) but RBUF no longer forwards them to
> DMA, so rx_packets is no longer incremented at the netdev level. On
> some boards the corruption ends up as a paging fault in
> skb_release_data via bcmgenet_rx_poll on an LPI exit.
> 
> Reproduced on Pi 4B (BCM2711 + BCM54213PE) and confirmed by Florian
> Fainelli on an internal Broadcom 4908-family board with the same crash
> signature. RBUF_PM_EN is not publicly documented.
> 
> This shows up more often now that phy_support_eee() enables EEE by
> default, but it also affects older kernels as soon as TX LPI is
> turned on via ethtool, so it is not specific to recent changes.
> 
> Always clear RBUF_EEE_EN | RBUF_PM_EN in bcmgenet_eee_enable_set so
> the bits stay off across resets. UMAC and TBUF setup is left alone so
> TX-side EEE keeps working.
> 
> Link: https://github.com/raspberrypi/linux/issues/7304
> Fixes: 6ef398ea60d9 ("net: bcmgenet: add EEE support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thank you Nicolai!
-- 
Florian

