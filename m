Return-Path: <netdev+bounces-284839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG/jJDxC+2lPYgMAu9opvQ
	(envelope-from <netdev+bounces-284839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:29:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C33D4DAF99
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 973163006904
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4C646AF2B;
	Wed,  6 May 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTitGJBh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529AF44DB68
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074167; cv=pass; b=rEVIdvlpw2lncS9m01oExXLBF328ITkZOA4GqgoJ1GUz2K2I6H4auhfDKQ1bCxiO0dlcii0Bj3or+HJUevWIAcpBeEXVBbZwp0bxoen9yUKeRyODf/8f0zbDBHdEhckr4NSvbNkAfk5KC2hXA+vPWaHzUpjsEZy87u54Ep/FP3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074167; c=relaxed/simple;
	bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHBBEFSO5t0zTXJLp2s6Ne8uGSfG5J3y7II61faAHE1I1uAzqRYT8WUA70EsHu56RgtTeqI9G6k2UBHHGFLzu/wJMYJsDV/OERzk2NlipWRcKUJSDCfK9kFcmdFpUE6G5aWmUV2JqiyCehkJgO4F6A9EZPzKS+YFm6XDxWxR9Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTitGJBh; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46ebe2beso61217677b3.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 06:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074165; cv=none;
        d=google.com; s=arc-20240605;
        b=R9kZciod7vQKqH2JFhuJ7Vly2uRMU/nbxVcm0RraG78zxtElp60VGcG3GddCzQ3/V5
         fUWQCW0w+07HQRpi0sDjabwVc8E90UeyS86Wb3234ZlIxsl9KYLfL5UQb+CnPSse5k5V
         2Sk9O72fj47hIe70kQ6KgeeRlKMvj0o9EHrYkQu4MpU1hAjXkuJMzV+Lt937AfP5xyax
         Q60ylmCQSQcKzkT/D7IAFCVy9nEAp5MGdJgZotHmalo4yhGuitAmzAy0gaFkz97NcWjE
         wAXFQ/dCc/n62p04RfsjyeXvnRRZZ+tIGCEqwPc9PQzckV7Li5l7+DgCP/TMpBg58948
         L2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        fh=VPf+UKdIzHYamRBo90e/mFICc2u+b0SbePK9Cfi9tg8=;
        b=WOiWoPIHxTHLKOJqBGP6e6Wl1upOqcRF7aPIE/RDOjwtqIX+trFoBMScDqGda6wxXn
         dx3dXlgcMbf5yyq6kCr7lXNMOPHtojY99w3bmN3445HIdJTu31s0ITEcbZdyxqj3J3MJ
         eBvklY/8hYz8WgYioZAHIVpHYWlPnfofQsOfv7OpY4Vpf+rul/2nB5WQY81f5l58clxz
         KNVoIb26fx/L02Xfx4uKpYON+WODcm0t1BxQR2R+6Sr9eqHbYK/XDq0oxMMjcBu7inlZ
         3/XnDdWhYefozKPexDtjKgxKCQbVybZhq+sDHgIhA3QMQb31f//cj1XAIvnz308mpcX0
         +G3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778074165; x=1778678965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        b=VTitGJBht6GOzjKzC2gl6iuHdVWI/TP1NsifnIchPgbewt0oqqvesDvy5Z1xX0Cdc9
         b0i3BcWsutNn2vIteKmqrnNzZdL8UXuFd7Nh5cvae3x4/mnUv5CDQYHjIdxiSy8JsrfU
         ZQzXsNgiU0AtYBf1wAgdiDIyIM89WLFjWqWNVKOrChJxeovgydf9MSdpY4dgciRBbfSw
         ldhZEz5x3KAPNwup7qjuMIANn53wbY8174k7SWhVZatQxsbvDf3Q5OHy6OqJXoSrecv1
         /T4usS8sDFMJIoCz2la+9z3RBhkDQYmMEY1TEJdrASGGsgSq6N8dH3udDqVpOGumcyEj
         R3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074165; x=1778678965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7alyTiuCbJiTCOYLhaXttQqzh7/Vh/2uu2iz06WTT8c=;
        b=ILAVLIO17hyxNGoQOC4v+ml5lmbm8O+OYdNtFL86mkAevkeZGfVu/hg/qp7WeY/3XA
         oGfThMISj9wVehsy2T93rR2EUoob47cyrIkdAtDkXq0keuAjESvpzTuzQWgaY2/p5YYa
         +xNxNUuWRbKGvjOAzeW5z9LsWJcBIrL8CTiv6ADwOiYMDTrDw6B28lkXfJ1eJeWn5XvO
         /oQVAVW/t/rt4xz+xvziRwB4ubKv6xcmA3Nz8uasiRHUkcBWtrzsqAnPuyHfYWvP/ZWD
         Urtf8cKMYmmAaecOi2LbC8JCsifXFKIZAAKmb83u+oEaukStM7qhS1QQCPb/LQp2Bl3f
         /NSg==
X-Forwarded-Encrypted: i=1; AFNElJ+I0cttj0kE7guo7Lz/Q7ipqX6mjPqq3t5CMoBdNrlt6Jk4UOGWRKSMjbFoed3lMV/EX5VHEb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKBBbRjePG61S3WaSH63YT+9yF+FP6XN2Wr4FoH4NVVAOCRVHk
	dNeTSZh02ZjkJqpxiLtUySm3AZHgS3zKkXPPiY+CwrijLyglGy4QbJ/95mEcwI10Mjg/VU+arX8
	Z8XTSobjpiixkWMAOKJOlfMBPwnUrQso=
X-Gm-Gg: AeBDiet5zQqFSh4TdSnbJGnR8YcdBYAnrLxm0qHu87fBxGZJ7+Zzwgq4cZkDql3b18l
	Xm7/mV4HntpotxGVB1B0dnz64QjSINfspcP7Ufq/gHXmodCSbjTN5Ns+z9FKL8oZs3LglLzHxsL
	6Z0Zwx7O3fWpUPvBB7T1hNqMvmQNWvt7Lt6segglTj0zSN1IOMjV2UU7bI665hsxNuVuFkYi6mB
	cixk53d3N+C7ntey6shzeGwBvD2YsHmkQjOMXArVRvvWyKnbcunwqQWEoJCVFql022/Az/w3PxU
	0BQVh/gWsBzX8v/ezy75g2mxIXtOOdroVFumc2pnkulJAfs=
X-Received: by 2002:a05:690c:6f06:b0:7b3:a5ae:4232 with SMTP id
 00721157ae682-7bdf5f1f995mr35858757b3.50.1778074165168; Wed, 06 May 2026
 06:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506120034.2146771-1-cuigaosheng1@huawei.com>
 <CALW65jYMfBN33qrWAMaNmnKfOd0eK4xA8KvCijkPS5mdBfoWSQ@mail.gmail.com> <6cd90b7e-473b-387f-7558-e5d14d531411@huawei.com>
In-Reply-To: <6cd90b7e-473b-387f-7558-e5d14d531411@huawei.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Wed, 6 May 2026 21:29:15 +0800
X-Gm-Features: AVHnY4IrKhRVdY6OeNVqSeZ595tsbEHCwaJbDJm4NPejk_BR5Na-c-htTE3eUic
Message-ID: <CALW65jYO_ShK91L1atmG8C_wrw4rXD1bbGZG0GEdTALQPcQshQ@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] Revert "l2tp: do not use sock_hold() in pppol2tp_session_get_sock()"
To: cuigaosheng <cuigaosheng1@huawei.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, gnault@redhat.com, 
	gregkh@linuxfoundation.org, lujialin4@huawei.com, gongruiqi1@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C33D4DAF99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284839-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email]

On Wed, May 6, 2026 at 9:11=E2=80=AFPM cuigaosheng <cuigaosheng1@huawei.com=
> wrote:
>
> Thanks for your time.
>
> ce63943f9bce removes sock_hold() from pppol2tp_session_get_sock() and rel=
ies on
> SOCK_RCU_FREE being set, commit c5cbaef992d6, which actually sets SOCK_RC=
U_FREE,
> has not been backported to v6.6, and after applying ce63943f9bce without
> c5cbaef992d6,the pppol2tp_session_get_sock() no longer calls sock_hold() =
but
> call_rcu(&ps->rcu, pppol2tp_put_sk) still exists and calls sock_put(),
> so backport this commit we need set SOCK_RCU_FREE and remove call_rcu cal=
lback?

call_rcu() here is like SOCK_RCU_FREE: it only invokes
pppol2tp_put_sk() after all pre-existing RCU readers have completed.
As the commit expands the read-side critical section, there is no risk
of use-after-free.

