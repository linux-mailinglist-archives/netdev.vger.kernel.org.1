Return-Path: <netdev+bounces-290069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJOVNcswDmoK7wUAu9opvQ
	(envelope-from <netdev+bounces-290069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8D659BC67
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F9B32E7F9D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245E5369D7E;
	Wed, 20 May 2026 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjudv8Se"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C3285CBA
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303468; cv=none; b=XHNbXJJeXiTWHdGTd8OGIIrS3DnkeVOC0OYLsDkP216+xbARG+9c54AjXybojRbKbsqLd7Ivm8It3bMktvYzQEJuwEHZgOXBshLezOpi1Q91ET6X5E9bWpDxWTioueqZvpEhRCeys+/Leq6VN+UUXRnPWm2Cg4m50aYgQO1KtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303468; c=relaxed/simple;
	bh=Kc2OJR4IiLheL3KZ+40TQBX37I/EytENBHyOBnuvaCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Quqd8VVi7SCYDDHd58P/BpSjaYEDk+nEdAC7QPBKr4WZwAG/xLNGl5f2hAwFmJqNK9w2dSShq6e7iBR0KL+SsKajedQx0KiJ3cTKZseq4cUsO1MNCJ4KsEt3nTZkUCHQjubwyw76FzM2bru+ORlXRMKbFE0z8JnMFYLv1BN/9c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjudv8Se; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39396f873adso78564461fa.3
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779303465; x=1779908265; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irt082pHwLjscL2WvgdVT5VGnKkuoPkasUHRPoDekQs=;
        b=Rjudv8SeBq4DYfyjxmZhgaAMeBB0ZbXnWE0npub5rWEd20XbFEMwUYYqgDJvjo7RYM
         h0ilDOaOkxGXtqk1Lf65qFMkUnwzlRJK0BxjwTrW+PBCYpGiyk26EUK52CogFR3R4k0K
         KYmq9XebgaRp1/VKAVDm7dgGrxGyLUlM90AZQblqsavr8eSYKUkdpBU/hS+8OV07vfAY
         fcyT9/J/LyLlZR/H32iWUs8/jUgQ8RDsHULDqgX/ANTug2XAKcAkPqvoSHnmWVgBggE7
         7M78rv2aUBcaGFnG3oEs905NLwSD/Xg1QQUnJq9sTOw82wuapvPQhQ5h93xs5nWp4AgX
         mBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303465; x=1779908265;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irt082pHwLjscL2WvgdVT5VGnKkuoPkasUHRPoDekQs=;
        b=VG1AW+f0HjJUSv46xVmYRkCeYDlqGVyLkHHTyZBnGfKhNAFF5KBp64Apj1fR7e/wqR
         NYojCAjFOX0UidgdSUR0TqOXjIWHjsRxcrFJ4YhgzD69bpe/4gygoqLdIwXlBDnugNrx
         wEYjDFGCP1BMLDcJY5tsLEPT1Xmnn3h3nnFWpoV8CTBKzqfXUXT2cfZ9p08jJMTNgVm9
         qYLJYe+iYMgAWOheLxWoZlpQ4iLQnD5QoU7nSuuz+fj5k1qjSUDyeYofMpXTxITDGLOg
         Q97L7xy0wRuWALxgQBpt3D6Br7nxuRz2FB7iSVfTK7dgeZMF+Y+T6oME0bmu5+JlTrxH
         q8lA==
X-Gm-Message-State: AOJu0Yzd1Qq9sb66W0TKoodcDvO2j+992M8hS0VFlnLiInRVbLBxYTp4
	7s5d9EwlR+f9b6n+vWlxw6atlHrLW1R5coz2fpOy9LTmt0vPINw+RdOm
X-Gm-Gg: Acq92OGI73P3Pih+oZefbQgXYnYEQqkbeq8WdNNtD8g5zqjpaNefODstSLrF9l9Vc0X
	dqig5K7nKRFbU0FeXpxJcNOov6AvhVRZwKEflaAXUsxbGi61QvTe6Y1aRSMIuNiuf4exJMXmZ7Y
	ZgGfETANx0d1FddogdlZNIPBYB/GNC1XuGA6JkagFb1cgHpxt8zuDKGNCYx3hMxnKzPdK0OFPlF
	3s+IJxLCj4jg5FZExOW8Dx5Vrg33d7bB26jtsvRXwd7BLgUaqK/2Heq8ZR34cd0uB40d9o0Dhw/
	tZrFIpmUIOGThabmSyXNJ5I9QYuzZwDVs2G/IuCg0zoZ3H7siMcJaFJc94uvlqRjFV9vrRR2o8B
	nYNjM6JV9vkQk0ul72THv0ERwMjnmqXExOzmvYVzmH0s2htoCKVCShxXIplCTgtQlGorOLe6ncY
	bG8cZL7Mm8/5lIaXN/73EDpsXGTyqIZWCWCkU=
X-Received: by 2002:a05:651c:1ca:b0:38f:e9fa:266 with SMTP id 38308e7fff4ca-39561fcff2bmr79553381fa.31.1779303464450;
        Wed, 20 May 2026 11:57:44 -0700 (PDT)
Received: from grain.localdomain ([5.18.255.97])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b408bsm30839601fa.35.2026.05.20.11.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:57:44 -0700 (PDT)
Received: by grain.localdomain (Postfix, from userid 1000)
	id 5471D5A005B; Wed, 20 May 2026 21:57:43 +0300 (MSK)
Date: Wed, 20 May 2026 21:57:43 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v2] ice: Fix wrong dsn read in ice_adapter_put
Message-ID: <ag4EJxrGGk_XMD7q@grain>
References: <agQ_xZUp3Sq905O_@grain>
 <20260517125307.287246-1-horms@kernel.org>
 <ago_YTTWiZs6G8_5@grain>
 <agrjuAlzsV0RqAwU@grain>
 <agsj4Rrexhkqao0c@grain>
 <20260520180324.GC988238@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520180324.GC988238@horms.kernel.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290069-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gorcunov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7D8D659BC67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 07:03:24PM +0100, Simon Horman wrote:
...
> 
> Thanks Cyrill,
> 
> I agree that this is a good approach.
> 
> I might suggest splitting the patch in two:s
> 1. introduce and use ICE_FW_RECOVERY_MODE
> 2. Address dns nread in ice_adapter_put

Thanks for review, Simon! I'll make so.

