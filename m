Return-Path: <netdev+bounces-215509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AD4B2EE8C
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 971007A75F0
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 06:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3A72E7193;
	Thu, 21 Aug 2025 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv+Ew2Wg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CBA2E266E
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758818; cv=none; b=FHSfT4FwYHTr0vBxRMYanGG3JP67xHRKF7+koEFPc2DfRBCPXMj6iIYQGlsWfvXAMtl5tmyIOXh+eLoTinSqW/xZ+NG4j+rV4c1nmRX0M418EBDknFMsWEyk6jxb/6FZ3xjmEBDIQpAedz2lOT53V9LJIMGQ7lwfplAUvWwepFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758818; c=relaxed/simple;
	bh=H7BBGLKirpU5HolAL8rEB2oiMX5QwfijH2Nuo9NDzn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbUGP6XvGH8tjOk6K1BNuOoG9yEKZMYteheRB7Z5/rB+aJM1lgmNgLWTOhY+oT6nh63arAbGL/VQLvnz/Vu2aXne5SKiO/nSvsL0qg+frtgtbn9m4K9TAgljf5pIY9OTVZE1TmTYFt/EZmY6yhIhtKAvw2PSn2Dte2YE81s1m24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gv+Ew2Wg; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b289cdc86aso6960831cf.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 23:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755758815; x=1756363615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJAJ7T4OdE4Wo7UVTut/FgXgd+qXtwJZX26cmpP+9Zg=;
        b=Gv+Ew2Wgw8p03DlUe3vULy/518oreBxDYxGf5vXvPGTO2HrHWNRZjPT3TcZJp54D4K
         SiIH7+fewWb6NJT87JDPAnu/bc4GuPdwkXUr5CWflrM71bpMuvnqyxWhpxDNwv4NnDAw
         FGfb55QLN86dtEWxr2i8gXRP6iCQ4IU+SXU8NOGYT1SOWgI52CFcbGu7lDIswgZzbPBI
         RPfVjm9LeoDfC8N+VcVuC9nFjqdgIAJZ9CAa1TPJ0oKMSfvaEwIUeeutv56OeFUA8Ukq
         7Sx6uolcsAL4txwPMQ4n1+Q3UxUjy6GumzbAR+aI6aZ/P+0xlvTOGQvOzNuWbCPk354s
         EyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755758815; x=1756363615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJAJ7T4OdE4Wo7UVTut/FgXgd+qXtwJZX26cmpP+9Zg=;
        b=Gq+c7ANVjFzJzhftkxXbubIT+CI+5CznRQqJ32+fcso3vTm25D9SGgWIiPaQ2pPXAC
         xQ+vfdi6WP9QAXw3vExZpm3D33Iehnq/08Usf4OzQ8YXetwTlZ/1yz0S4nwYSwnlKAEu
         nHlSwFynfYhT9AFavjJtdOQ5y6Encatr6NaAg+OMLLKI5aDcygPer6Aff1hlMqKKYe5J
         i7JGEY9vsbBpNRN8cHlFBHXFzRuVK+xHCOzLbPE3xRoacvw4DsO+pJX+BUWwRi7qRkNg
         +QLTSx4Pt0ACSr3qNhIkh8Qy5g1XTa3nYTEcdXg+NWc2R3Fiu7LxDth04vv6cucUmm+p
         pFZg==
X-Forwarded-Encrypted: i=1; AJvYcCX3SSzlohrzpyyK6+GwCC+NpXPgv8AbHlIHk20szMc9AzYC+/oCLEFk+COM4ISbMsTcmyHelgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEsVNAjCEriG6U30RWZ6abrb3tjwnc/52SbVw3MRD8jxaEuUM
	GxiA13NgDwehKUs6b20jxZ6oHuiUedN4KMtiL2BQISOtWWgw5Rb0mQ1WlIFL8lx7aiwt8Xg9dJI
	UdWrOgUuUErXKQNiHyQTe0aADrGi7Dqb1LN5MOH4t
X-Gm-Gg: ASbGncuP/3NACz1HVL1F9LltgTiwr75lsdKiaRj0QR55XVivId0TJOAlhY6qxq8iQso
	enYXFagOaSVilMbfdP9WXtJqHN8EbhdhUYO8cHbQY3cWVP6CEui1XqAZnetIu3X51W7WhzPp5Dh
	TiHK6gfK0hofEA5g8f7jVylaR10wYzad5AVEbl5XThlcmdD5eVSgBl0kt+dJtvIt9Nn7/SFNmba
	wdW2HzA2IoaiPHg67+E+osnCQ==
X-Google-Smtp-Source: AGHT+IG4hOMoxFdBkBFcM8/uYXHPW9MVJg9Cp5fjNdQq/+sN43vFnBcAQ8qygEh59gogJDlu+VP2kE2LcirAWSRc52k=
X-Received: by 2002:a05:622a:38e:b0:4a9:c2e1:89c4 with SMTP id
 d75a77b69052e-4b29fe8f32dmr11780401cf.47.1755758815125; Wed, 20 Aug 2025
 23:46:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821061540.2876953-1-kuniyu@google.com> <20250821061540.2876953-3-kuniyu@google.com>
In-Reply-To: <20250821061540.2876953-3-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Aug 2025 23:46:42 -0700
X-Gm-Features: Ac12FXwr3sQPTIXNJ0msSi3yBxdEqzap9vM6lAieFTAG1zqfoiu-twXD2jpP0jk
Message-ID: <CANn89iL+D-OcDgxWYVP4vufeuOESrz=jy-wknM=Bbb7qVZoJuw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 2/7] tcp: Save __module_get() for TIME_WAIT sockets.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:16=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> __module_get() in inet_twsk_alloc() was necessary to prevent
> unloading tw->tw_prot, which is used in inet_twsk_free().
>
> DCCP has gone, and TCP is built-in, so the pair is no longer needed.
>
> ULPs also do not need it because
>
>  * kTLS and XFRM_ESPINTCP restore sk_prot before close()
>  * MPTCP is built-in
>  * SMC uses TCP as is
>
> , but using tw_prot without module_get() would be error prone to
> future ULP addition.
>
> Now we can use kfree() without the slab cache pointer thanks to SLUB.

Right, but kmem_cache_free() has extra debug checks (SLAB_CONSISTENCY_CHECK=
S):
we check the object was indeed allocated from a precise cache.

I would prefer leaving this in place.

Such a conversion could be done globally if you think about it, no
need for hundreds of patches.

static inline void kmem_cache_free(struct kmem_cache *s, void *x)
{
      kfree(x);
}


>
> Let's use kfree() in inet_twsk_free() and remove 2 atomic ops
> for each connection.
>

Where are you seeing the atomic ops exactly ?

TCP is builtin, so .owner is NULL.

