Return-Path: <netdev+bounces-254859-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Gd4OH2Qe2nOGAIAu9opvQ
	(envelope-from <netdev+bounces-254859-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:53:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DACFB277B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B83AC3039C8C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7AC33F8DA;
	Thu, 29 Jan 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUrqUv0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A673C23D7FB
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705508; cv=pass; b=G6GQGYpmBoc6awralLYWG3dVAcVBnfi351I73SCpJf8BsmtKU8sA2QFS5fvvgGEyTNBHH3zjqJiIt4/IyZ3UK10ahvmAKPvMGzPpnhSinQvEXKUztP78wnpdSsgSKsf0Q8JG8iIghAWO5P5xyfN4JV4Z/OTl9tFk18eQyfJj9bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705508; c=relaxed/simple;
	bh=VPO4Q+vhHUgkJh/KQvTk2BBtwUeLWCAhW219yMEjWXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UjKK0wZ3Lu0Y3+Vf9sS/FfawHiyL6fYAwkK60U7o05H9u5zTm6AjvDh1hRVDiu8+VThsNi0Pv1De9tofU6TlrNdVeYHabeWj5zOE09tdQNNkqlVHE6MCDiVWnZ73pWdlJt3twdM1ItWW4mak6ax/Hn03Wc2nQoi35zJu7TyqGEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUrqUv0v; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so193717466b.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 08:51:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705505; cv=none;
        d=google.com; s=arc-20240605;
        b=HBY4o3smSah2EVaZgDfMTuqHYElpV8qZdvLwZVcn0UGylbiWIXh7dakTjLfotLIVx7
         R0szF16T1/dbdeYiVgwix8qwMZyXudn4j3mzQKb2KHOdtYOhWVij5Jln1Pb3h2jZ1e2I
         ND+lPL9hpiY+DWLLxnu42hhV30STwTZxS8FAemvjDuQ0juRmP4BDv5LEqbIiXYVLdTrq
         GzVHmyFwZEnDQ2fxagP1YYiW2GRXZ3T4zZCmhNgwrTP3VJ+4g/duPqw3rUVKJfAcv7KW
         DLNJBSi16c2tm7eu/pFsBhHiCtMJqJiDWYiIS3VD2QNdnKByrUkdvE9oqaeadROi69nY
         MBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VPO4Q+vhHUgkJh/KQvTk2BBtwUeLWCAhW219yMEjWXY=;
        fh=U+58nlHW7KCdMYQJ8RV7TtrinDo29WCw6/Ez6SDRNvA=;
        b=D7uto/1ohzF6K9ebysDDfGLtias7jan4I486h6kKWW++yv8Avkcj7QQdQuzUJ4Ga/V
         NEWpdPwIRngWFr7c4ax4LOMlizUxYLeCDtEFXfa6LfRVVw5vYNHLLc6LqwzM43LKI8A6
         paCPQC8lXmWRcJ4q8MBmUxUABLTn8Pi1aS4LkVDh8NIcRg69EPxnG/1ltLth7qbB7kj7
         4Uf92r2Oe53sofyxbNPzZPVTB2zF50zR1Xj8sOftj72pOx8tiojxijD7ZhH+7umUVmWd
         IxN1TL0aS/0v0f9zpotmwTU02kzA9dCMYARlfih1unnGbtObZ6zq6w8OA9bi6uUB3kaX
         nC+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769705505; x=1770310305; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VPO4Q+vhHUgkJh/KQvTk2BBtwUeLWCAhW219yMEjWXY=;
        b=gUrqUv0vfe6PsjuhGDJ8HTchPNS3nV9jfLJCSPXtJExI0BxCqMgpzI7Y8iYfLflX/b
         oP3tnIvif+amO4iCdxIbF+E+21UpY8qeE/Ka3Z7K/3nsS8bAqvE8kUL78Ccq7QOK0Tvt
         EvAOkLsmFklxlBwCD2GInDDbgYBQhYRd7zFyVDTpzM8OYeX2L5NPXV4YZ9Nr/vjnn7oz
         g1niODJRWCUw4e7EG+9HwW0DmMoUAVoOrBNRBFEPZyghDZEwqhkpJ1zyPcJUqkGzRqHZ
         8/kycvCeOSLxaOlo3EzJBJw5BNvzzko7cVfzIbYYSSIzYe42f4eZ2R/fvHiIjbRHD3Ra
         8ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769705505; x=1770310305;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VPO4Q+vhHUgkJh/KQvTk2BBtwUeLWCAhW219yMEjWXY=;
        b=Ie4bdu/ZDJgpyPVwAbO8XSgsTqVgX0vC1Z59Nua8esIyxcB3pN5evUNYdcMi8z/iwl
         CslVi0s3Uvqj/Lx5XCLyJCbcTMRkuFDZWDJIkBbqkfR9geAc31CJ1xL0lb2LYy+SSbDh
         1kyWQp0Owj8OIpChu/YE58UxUsH2fUsqhrHl2K2khenqXa8kfYLIsmkzj5QTRq84VK8p
         Vhpm795FGMKoeZOIjgLjD20XMp4OKmAE8pelMRHgtbtJjGbuk8R80sd/K76pv1MaS6aF
         7dtP1ri2Gf3sFGLbXox9vxtTusVkQZrE7fTmlVZ0/mf/vpFC5jfzEO95TsxlLXZNUvZv
         pj4g==
X-Gm-Message-State: AOJu0YwNKyz3w9O+ZPtgGCOu6hAuubyl7JdNqVWaaTatL9pvfwRvMJH4
	+fR0j7D4dEkOzdqhY5m48VxpPsQtvEGfNVmbQwkpCQ/HgsTGNlW6sey+rggQCLkIE+zqzIaQHNi
	H4wRetmk7jXSoG2GuEt314MZvqao0bxFi3W9l
X-Gm-Gg: AZuq6aJNPdTYD2qBwcIdcRKKIlYek1wYJJ4CVQnc8PUY5FikwTtsc9ARAlMQlZqTNjv
	KUy4AVKQj+YUI9C8NwvqLA+TD6Ee9VjYjO3Pe1ANKoF9KpdzdCXCagfO3emaC/nM5tocDwj4zcw
	+SlmqWJGtF0gr7jA78tMtBp5ocurfCfq3YFuOHeWMZliXhgsuA6JmR2JZ2WZsJeUoE+v9DL3W9y
	XX7PYVCTucv/w1/JDpCnwKOD9bEmEEhVZ1DlJcAMjLYO2J2z86gI9B+eDhgT3ylCw5b
X-Received: by 2002:a17:907:970b:b0:b7a:2d:71af with SMTP id
 a640c23a62f3a-b8dab3310admr708324666b.38.1769705504821; Thu, 29 Jan 2026
 08:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFWXMN3WexdQEsjZRGumLuyA8phXmSte_j7JTAjL_v11ZxAmtg@mail.gmail.com>
 <20260120214802.270100-1-kuniyu@google.com>
In-Reply-To: <20260120214802.270100-1-kuniyu@google.com>
From: Gopal Malaviya <gopalmalaviya53@gmail.com>
Date: Thu, 29 Jan 2026 22:21:32 +0530
X-Gm-Features: AZwV_QgCURsUBoDkSDUHRk59KjdzEjQDtAQb1fkbaXXF_Gp08EI0pq3btPCXp2M
Message-ID: <CAFWXMN0aRnrb185FgExki-TOwee0w7CAgVpjfu35R7WLDtm+SQ@mail.gmail.com>
Subject: Re: [RFC] net: ipv4: optional early cleanup of half-closed TCP sockets
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254859-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gopalmalaviya53@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DACFB277B
X-Rspamd-Action: no action

Hi,

Thanks for the userspace example using ss --kill, that is a helpful
reference point.

Apart from userspace approaches, the motivation for raising this as
an RFC comes from scenarios where half-closed sockets are reused by
application-managed connection pools before any external userspace
action can detect or intervene. In those cases, polling- or
admin-driven mechanisms tend to be reactive and can race with reuse.

The question I am trying to explore is whether a narrowly scoped,
opt-in kernel policy tied directly to TCP state transitions
(particularly FIN_WAIT2) could be useful for workloads that need
deterministic cleanup without relying on external tooling.

Happy to adjust scope or direction based on feedback.

Thanks,
Gopal Malaviya

