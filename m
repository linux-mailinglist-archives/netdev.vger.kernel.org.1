Return-Path: <netdev+bounces-256822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCDTI2Wwg2l1swMAu9opvQ
	(envelope-from <netdev+bounces-256822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:47:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F77BEC90E
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AE57301A737
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4586439009;
	Wed,  4 Feb 2026 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVMlI0xL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF7439005
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237994; cv=none; b=M9kTAwnHh/Ez1r71HgO+oVqyMd5xsc5PcijwNjUtaoUjcTUq3EFeOufPFJ4rnDPj4m1Fq7I/F268krvPdGlm95DYMl+/ZJ36/RoLyxfeHCClXJ0vAeAHKyjj0A1EBkFRfkvg5A6cjtfklVEyCp0tBSKDq3WFSEPezWeXL1Umud0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237994; c=relaxed/simple;
	bh=cZdbzn5zJVjZIEe7/tzsAfFiszw+/L5oMJqAvM37icc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Oxz6Bu6e3ciafBtRRXiHjciPC7WvrxMqZKc2fWqXPASU/Vy81ClQHHsYdxnaN7tWzpBj1SRe2x2h6EukxN1u244lVFSWA1V5QQdPGNUCJJKfddTiaMv4vgcsTuKkPm6dNFA4zIzoY+1lYyK3Pas7B0oYNZV0sDBpCoSq1y/n1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVMlI0xL; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794d80febdaso1965247b3.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 12:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770237993; x=1770842793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WCa/5leyVb0HfwWNsS0eZiKuGQsz93x+xRuXmo4lowE=;
        b=BVMlI0xLXQ5lY4c50+f7OJ5Qn10OStia3iM1mLOjQ/ydsy2Hy0tqBZUCQAG8dt6pEx
         98mL3ipMo7FoNnqENhxrCKGxFqK77ZjETk6tRozBADpbPfjusbCTlU/VPm0ayNmzih5d
         wKAZpTFqsRS4+rRiKaVKgS45S41q4O6dk0dex+5ibtekL6n6i9ceise9Kbgi0WNMEkII
         g1nnxq0DFVnDG2DctKDMN5Wvms6nlKfux7YXGonSVitMQjXLbmAM1USdYIcf+4JOwSen
         Qq2eZ4GquMya7bXyswNSgQt2ViNLdLhDf01pYTWy2pfisp4DLNvaqNFIkb4ZXNhQOcGw
         ZWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770237993; x=1770842793;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCa/5leyVb0HfwWNsS0eZiKuGQsz93x+xRuXmo4lowE=;
        b=e/WLb2YGyXX7Ebb52QSgxio+RqxsCdZqKg7tgfMB416WbfP0SMId4uBvILsslDfdWV
         cE6BKAnM1Kmhu2N+nKH6bZ9d8mNhP1QriQ3vTNh4tJaUrQWWabwQaPanv1bUMji9lQyS
         574qEYccNmbcM4vgHjAjtN72TJ07TcoNtU0+lxH9B41f5wuKfZPyFWLvWOx8QcQFcMoq
         1vZHAcAVRo/CyRSTfx612bxOenD+Ff1z84nHEYB7dE3f7SmNR92nrgAAU/NBjXiO65JX
         EhQuoIs8/oVFi9uqobuESRbGW0K9tUCBbJjufjHpTYWEp2uuXhkKhXN/qoV8BJ72N1HZ
         Pr4w==
X-Gm-Message-State: AOJu0Yzw6WKq/AKgqQQ554FaZAxqIsHaV9/hZsoAs8z6cn1BIIFFFNQU
	neIa49sVrDab6wH0csooYIjS6F5PQm0AQMfMlMSOoskdKcIpLIZejMjM
X-Gm-Gg: AZuq6aI6+F9Ii4/PihZ9KSlKVsOQG9nPd1KrjoGLigHVj4L9rIwa9bsb9rZ7u4TN0Ch
	iJol2U1/0xucp8z7/YAVOgAXbgC7Rp1Xcq8MnzZIM+ZO4R5CbdDVXVWAgK1oeBQT3neLie60av5
	2D/deNf7BRZwhxZZJWdWMmYAUxAL91rRANTFxhzooxq/sw9Eo49C6/PF7Fd+Q3uSSbtzGzIjHXU
	gBiFYhY8rWHpM9AY8x8OpC68ZH5x/klHQsEmEQnAd6/kkMGOykoMTuzKveHrETN9tVtBAMJ768x
	sdJ1VwNgKyDqdUDz2ZGu3BarNrUs+1gDjAb0TO1pOFLht66dgOe+gXbBxTUkw5mRgPAgMmsCTlD
	BpngvWoFp1nbpMWgNu0ePJxpVa9KV6oi7BbmBLubr3sja3Rum41itn7p3pIdQNj+e9ETeYxDfn0
	ipQ2OEULSwct5P1VM1vvtJLp1QkPws9bw7hQdsqaf6UwO5LaBwvaubd6JG20c=
X-Received: by 2002:a05:690c:7403:b0:792:6c16:110c with SMTP id 00721157ae682-794fe7e2f6amr37355227b3.61.1770237993416;
        Wed, 04 Feb 2026 12:46:33 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794feff620esm30244707b3.51.2026.02.04.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:46:32 -0800 (PST)
Date: Wed, 04 Feb 2026 15:46:32 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
Message-ID: <willemdebruijn.kernel.1fcb030747672@gmail.com>
In-Reply-To: <20260204-psp-v1-4-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
 <20260204-psp-v1-4-5f034e2dfa36@gmail.com>
Subject: Re: [PATCH net-next 4/9] psp: refactor psp_dev_tx_key_del()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256822-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,lunn.ch];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2F77BEC90E
X-Rspamd-Action: no action

Daniel Zahka wrote:
> This is a pure refactor. Lift the list deletion and key validation
> code into callers. Subsequent patches will have different requirements
> for what actions need to accompany psp dev key deletion.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

