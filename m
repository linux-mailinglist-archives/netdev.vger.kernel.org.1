Return-Path: <netdev+bounces-252339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBgnKdImcmkVdwAAu9opvQ
	(envelope-from <netdev+bounces-252339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:32:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1601E674EB
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CFBB15EC576
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0C938BF7A;
	Thu, 22 Jan 2026 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgkKq1ND";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8KqbCmP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6640033A71D
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769084641; cv=none; b=RweKT2ioPiM8zyderg9FYmygYoQcZQBa4C/Orwn2cGwLcVYm5Oo9m8ZNOXx3g8VmlFzxrNT4kRrRz/1gm1fL5I8sn9udkh1f1avOJq61lqylsHSzkeetOGaKAmjCiWYY+svDusBIpe6pcLLALdVbKFWB/ykV6Hg8mhwTL7XyAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769084641; c=relaxed/simple;
	bh=CbkhgR46Zm77/M+4UC5otkqe5oqfCe1CQTunZhwtgeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tr9PeeMdzuxipNIPnPRoKmPw7+45Fr2OwSnadS4V6nLPBYEVyeEn5Sup49SOJRyg0McwAvJUx7vq8m+oEbEPleQkLQgOBPPopNgW8z+VttelIwiWnu89e5z2cHC4eZWYGzGcY2588vDVakw2bNcVGAx11YFKJhykm8EvpvZBopQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgkKq1ND; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8KqbCmP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769084638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HDkVo4hJqKcY8aS9Cps8su9WoS5sFWEpHKQyTLCzYYY=;
	b=cgkKq1NDdps5T4cGsdCM+4pFOSQWgCF4rNC6fWuIhi5BhQx88dAaJ9BF1vQqxO6feiFpGM
	BpKO7i6l1wrMSYZITofKQcZttjAFDq2QAQS2Ir2d7PHj7puPuuRDnV2R6oOfjKpGTMiTKH
	y1ycGtSKiLi4jzNQESQxXrtA5jZaKPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-8fdHhfCPMw-Q3IGaN5i69A-1; Thu, 22 Jan 2026 07:23:56 -0500
X-MC-Unique: 8fdHhfCPMw-Q3IGaN5i69A-1
X-Mimecast-MFC-AGG-ID: 8fdHhfCPMw-Q3IGaN5i69A_1769084636
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee33324e8so5515635e9.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 04:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769084636; x=1769689436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDkVo4hJqKcY8aS9Cps8su9WoS5sFWEpHKQyTLCzYYY=;
        b=U8KqbCmP49jKYp9WVeOqWydeooArymQ22a9RNlh6u113u+1JSoWiKTtO78TQ0i4PmJ
         8YpZA0oFiSsbNKH3EFg5ClCQeovlNwjtq4/aPpxwtp4WPz9+RAY5DZetjIgmP5Z2dr4x
         bZVMrNNTYU25AKJ7+Ck0GUqk/au59widu/OhLIzVa5Eb1EF5APJFWOH2dgMr7Km8d69x
         A6ZUbpZhmbSJP7EsBkK9N20ItIr3KcpAuZl3COyIyCRFBZDAI9/mgH7ItGXSsYmwcXL+
         KnamyuWN7tp0IsmnX1nxwTJm+KLWCxN326aZPRmyjdQZsraPmp1QocTIoH/yX4w+jFkX
         ihtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769084636; x=1769689436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDkVo4hJqKcY8aS9Cps8su9WoS5sFWEpHKQyTLCzYYY=;
        b=EbDq02G+z5dLXoqqLO7ZNtcayOR34xbTc+4DRQt2MpwUdSaxSuaXLwWpyPRPLhuFW6
         FufEc+P2t5FRH48jyna0V9EeBqKHdKY4axLWDO6ZMjJ3sNOMnjHxRN6loLtSE5qUtCmQ
         Dy+jRcvWkwXGtNU0oYNDOeCic7D1s+GTElzZjTt1kzRq6UZNULEcg/amqfUn23WidZNC
         kxh9vwulGkzCAAgKtQD2KlLPAagiYihyDJB9jHcn76GeLvPISq66Nazyglz2NQVtCcDU
         usrP5qZtgqaAeLSm4iT9XMOd70h8q0vmteigfD+6aOmtUJZUBadL2LhaCpLbmRsZqimK
         ZWaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjkw1fBaDi1eCx6ZT7v8lnGC1nJCZuZ3/0yxkjI/pdhKUH2cpscpFYtOL9O4kAnvj2dVz+X1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8lz1N12aNwGmZDREm4OelfFrIeWkG739GEWJZb+ZoiZJ4HPjq
	Q5CBTd84qnowPh2Ap0pmd3aun2ybh5csOMhgprTdVQ203rT9HyAGoz6egrtGKXZVijV72xDirq4
	TU622/sJ3CFZnKWDq/WDRbFIOjKKvuBIFH1BXW9TT2abEyKTgaoqhuk+duw==
X-Gm-Gg: AZuq6aLhGZ9ywZCgItt6A1AZiudkX9SgKtz4xZeLDHAqMnhRdhO9XBcCoZ/2ZJf8Wao
	TNTbuddK8dJ40Rqf3JzSwqDIASf+H9LYj8HgvcWOnxqvDvfXsc5XT9xa5Oey+RBB37jhKdpV4IQ
	Et4p0yCiiBuJNzQdIeAvH2WUGnetkazXJci26cqMRabTw1qzXMlO1bybpH+vc0f1kjXiFVoDitB
	6C4e93yj5W569pyC2rqdpxQwXAS+ddyKM3yxpaxbXPPYWOzbev9LeJxiqP/yVz+CZDmmtpp7krL
	O3fAiKdQ9iMuuAHN/TnA9n238beNzZuCpFU/NaZ9MUY1gVysuF99UDu0rU6ai3qeI/CbsZnL3he
	DXJnyl3PUyacV
X-Received: by 2002:a05:600c:821b:b0:47e:de9c:92ec with SMTP id 5b1f17b1804b1-4803e7a39cdmr145313625e9.14.1769084635668;
        Thu, 22 Jan 2026 04:23:55 -0800 (PST)
X-Received: by 2002:a05:600c:821b:b0:47e:de9c:92ec with SMTP id 5b1f17b1804b1-4803e7a39cdmr145313225e9.14.1769084635263;
        Thu, 22 Jan 2026 04:23:55 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.175])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997ed8bsm45340078f8f.36.2026.01.22.04.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 04:23:54 -0800 (PST)
Message-ID: <578b5c27-0db5-4185-ad3b-cb35bf864d18@redhat.com>
Date: Thu, 22 Jan 2026 13:23:53 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fec: account for VLAN header in frame length
 calculations
To: Clemens Gruber <mail@clemensgruber.at>, wei.fang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, stable@kernel.org
References: <20260120160407.101273-1-mail@clemensgruber.at>
 <20260121083751.66997-1-mail@clemensgruber.at>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260121083751.66997-1-mail@clemensgruber.at>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252339-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1601E674EB
X-Rspamd-Action: no action

On 1/21/26 9:37 AM, Clemens Gruber wrote:
> The MAX_FL (maximum frame length) and related calculations used ETH_HLEN,
> which does not account for the 4-byte VLAN tag in tagged frames. This
> caused the hardware to reject valid VLAN frames as oversized, resulting
> in RX errors and dropped packets.
> 
> Use VLAN_ETH_HLEN instead of ETH_HLEN in the MAX_FL register setup,
> cut-through mode threshold, buffer allocation, and max_mtu calculation.
> 
> Cc: stable@kernel.org # v6.18+
> Fixes: 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
> Fixes: d466c16026e9 ("net: fec: enable the Jumbo frame support for i.MX8QM")
> Fixes: 59e9bf037d75 ("net: fec: add change_mtu to support dynamic buffer allocation")
> Fixes: ec2a1681ed4f ("net: fec: use a member variable for maximum buffer size")
> Signed-off-by: Clemens Gruber <mail@clemensgruber.at>

A couple of things to remember for future submissions: you should
include the target tree into the subj prefix ('net' in this case) and
you should avoid sending you revision in reply to older ones as it may
foul patchwork.

No repost needed, the patch looks good, I'm applying it.

Thanks,

Paolo


