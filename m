Return-Path: <netdev+bounces-256821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHczAC+wg2l1swMAu9opvQ
	(envelope-from <netdev+bounces-256821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5606EEC8F4
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 21:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891B3301AF64
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA96438FEA;
	Wed,  4 Feb 2026 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLm6F9P7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99973D903B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 20:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770237968; cv=none; b=lCTq3X2aFZQYgcih/m6AKYBH2TEK+KwaxT+9eCIqiHUi5akpuREjOrbzdKtIDbvmdv4K066pysFw9zM4zz8X+HUVx8IAFs/8i493sREpNQ0tCDfyiJpGub09Tv6G9ZF9H2qzVBEfiX4MijL8vWUDj6GiMPKdZfz/n82hnFxp8kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770237968; c=relaxed/simple;
	bh=qWOblQYebZr3b4DNcrCHxa/N9wKXw3nJYtVNLvKaaQY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=R2VuvyrJ35EYNp98N/azLYsbPEFsq0QV4Ll2LRZprhLWpHlV+BbtXlsf211yq55Uhq0jz+uMTKDsq97j5rwIytMa01wI3WpDZOtqOM+YWbsrwjgSu3RByvLIkiNpVsXfnh0nbXXhLBbjgD5uR/1ELoYQYmJRCz1FrNTlaUPkwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLm6F9P7; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7948e902fadso1963707b3.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770237967; x=1770842767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lv3YIJDutvl3nESEPNZZVBaLc1dGe42cfk2JLGqHhBo=;
        b=TLm6F9P7ldF+YU8Rwy9dxlZr8s/xBXZTQegnDCJjYcbJSfTUyGrO369x6qjkHLiAPz
         mbQvXQv+K488XglrsyVPQKIEAZPX0hfZqTwxs57R0vmJyeE8Ycjqeo0UWAFXM3cWvH5n
         w6llfBE+zhA7RxgdpLT6WjGazLzV94I5cx8xO9m7DYg/QlufefjL96Wf0LLnHJE/G93B
         HqJOeapor5LJrsSPqp76wAGjh6hBcZMkWo8s4SdD+7H8mM2BK3/IAc1WlLjH6j8waZKT
         Absn6D4bknL/lRkzXLIct1s/RZkXKSsWV1gtHL3FgKZn6rjGUP9QCvURd12cb/Vjb63y
         UdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770237967; x=1770842767;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lv3YIJDutvl3nESEPNZZVBaLc1dGe42cfk2JLGqHhBo=;
        b=uqX2P0Bb5ZaQ/TJo64Q9wY1bfnkoAZl+JHrM461SYUTPF5lxo/tjpultgd8icVGwUU
         cZUGRO2h3WqcZQ76eP25FekPVDI9R55PyeeS2uk9Pb8FmOOXLLzAZ+/+UwjI9NudqDAI
         kpz2IWXPHl5XScXNATXCP/nz5p0XD3dXEsjpexcpe/FC+d3+nC58nQKwntBHWkkQemyi
         nOihbH7dRQgxSxnhZHrjsjtHt7f3ItscC/Pc+5wbksDYHyw39ndw9XjRhk7xULt5N5K/
         LsO7ZcMr0pkCa/j9LTGrfnqD30rdO+tTvy+PQ8Re5V2JRrNoqiodfsO/G/BYnC57JqK7
         N+lg==
X-Gm-Message-State: AOJu0YzR4ynGVfzfVQugJM5AP3FPfenGdowH9oObPBbu0yZ3zTzBzaiU
	17/ALz/WHdMSnxwE8n4vtn7OFBu5tD78vjDk2GQo/olnhJ2S5jNr6vn2
X-Gm-Gg: AZuq6aKq568PHuScsopeU1797nHLWRKmYyqvVD4B+FemC29jp13ZEeCwfa2ddtP0yAK
	ZqRxjDVCRzW32clq8kqNqVApyg5xlDqRoJRgcxLFv9ggskBWb5ZoOHQKFeZZaeX99Eqsek7hb2M
	jQedQam/HLpdsztkIImh+u4ZLjQmEd48OclEegzVHwHJxydDJij62CpMU8V5wIjZh8j6X5K+nq6
	NYiAizcH46aMu7Azq3VF5ED/7nSjhid6mPqo8/iX4uLmpfFkvCmLIBk+jiR8XBh1/zGsnV2Z08h
	i+PAa9pJagzIOtgY2KxRPG2XLQ1SWwYH0I5Ut6X8IeCFR27M4/FKSJfzA22QtQ/fsZcnzDzgKLC
	nOwefCizytGY0PyJqZnngr2UFY/+YDIzedbCI1iK/6kaOu1P0/E9ChZ1lyVw4DFcny8+nMduIDE
	Ydn2plm41bQTE2kUx6rR23iN0AqwQHivfxxXzB5iu/pKpBtVEiCH5SJBuYRbEVX1FeS382QA==
X-Received: by 2002:a05:690c:883:b0:794:fcf8:f822 with SMTP id 00721157ae682-794fe651c96mr39194847b3.7.1770237967533;
        Wed, 04 Feb 2026 12:46:07 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-794ff0144e9sm30202817b3.56.2026.02.04.12.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 12:46:07 -0800 (PST)
Date: Wed, 04 Feb 2026 15:46:06 -0500
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
Message-ID: <willemdebruijn.kernel.26cf34e993f40@gmail.com>
In-Reply-To: <20260204-psp-v1-2-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
 <20260204-psp-v1-2-5f034e2dfa36@gmail.com>
Subject: Re: [PATCH net-next 2/9] psp: move code from psp_sock_assoc_set_tx()
 into helper functions
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
	TAGGED_FROM(0.00)[bounces-256821-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 5606EEC8F4
X-Rspamd-Action: no action

Daniel Zahka wrote:
> This commit is a pure refactor. Its purpose is to lift code that needs
> to be called from both initial tx establishment and tx rekeying into
> dedicated functions.
> 
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

