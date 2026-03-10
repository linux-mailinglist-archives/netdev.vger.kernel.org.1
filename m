Return-Path: <netdev+bounces-266245-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLHZNMVPsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266245-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:07:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F02553D0
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6FAF30AB0B2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1DE3C945F;
	Tue, 10 Mar 2026 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJlCKPYd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq6Iq6L0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259193C873B
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160733; cv=none; b=gateoZUi0a14WSiPDcw+wDhp1r2YabeuKf29m5Y5BuHOXZpuiwc4y8dGCavL2XlOhxG5dDps78cJ6jkc1mXA6gQMpu67PXvcc0KarYvMM1JebN9dxSgPt+7pCk1lpkXN+Z1QtOzYbvNDpWfQHEdNiZvSbc12YogXR7myJH0qbzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160733; c=relaxed/simple;
	bh=QtsqEkQzN9xVOyxOhg30955iCjs1Cv5lnJJe4hLbfB8=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=NpDEkcWWIn1vrh9ozK6OoA9jcrfBn4JGokv5v0IHK/FO8TXchRNtfAOFztt5AqSDHL+xRwKN0ytY9gOaN8Wn17B9Mv6Wasdynyqpts56+j1g9tM5pR8/nVITvynKpRcepPsCChkEXehx8Ak+NoQdMw4n+5iIVbjhTUMmuvr1mz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJlCKPYd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kq6Iq6L0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773160730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jKyIeeS7eeZINByUKTL5F9SGyjIIQhwCa/DKj3QwiDs=;
	b=YJlCKPYd1RJMyRTpl22zH30eSUarCOEaeFKXKHaISogBEC9qQPkiLWPgqcn0D17kcM+PBw
	ORes1B+Jjk5xbOAybv9mrHO2pYf940v9sziO9w+qtq5V139KJJ/NMO/Px5tATmGHsibBY4
	JVGCTEGtSLD+pU0dJXoDn6RM89mXjsc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1ZtV7e0eOeuHQfTeqnix3w-1; Tue, 10 Mar 2026 12:38:46 -0400
X-MC-Unique: 1ZtV7e0eOeuHQfTeqnix3w-1
X-Mimecast-MFC-AGG-ID: 1ZtV7e0eOeuHQfTeqnix3w_1773160725
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so24467615e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773160725; x=1773765525; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKyIeeS7eeZINByUKTL5F9SGyjIIQhwCa/DKj3QwiDs=;
        b=Kq6Iq6L0/0WosQmwNuR9Gk+TMMLNnZKVAIbrzlA4abYMFbKgv5JdDYbsQcaKHYl3Gn
         /DyE5M6D+kRzWcQ8act/U3Id93mlxzS4YtKC6Ja2Tm110rE80N+TnaHKV88o6P2llkCQ
         XcTAN+FGdRZwV/0WYi1nz0wN/LlsVylWUbk42CRCChQjqjBGl5FG7Laq5VWs0xySZH9r
         luPY33nyHCZIb19dlW4W2tLkE1ykVRStZY0IdJ3wW+zP16PM97wZtqNV2m8URBC4y2JR
         LpyTQGg9T67eh/1c8ccm0uqZ7rgA/yMjLec8asuiLS+sIlGoSugeN1qj4sLfkW9E82x2
         dTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160725; x=1773765525;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKyIeeS7eeZINByUKTL5F9SGyjIIQhwCa/DKj3QwiDs=;
        b=LZc+/CR5zIR3Er1Zp2wVrqEMJBJRuVxOZ/zl8Zpd7kcvFPf+ZW1j+j5mbUt0gO80zI
         naYnYC/Qg9cAdBbJywgdWLnWRizKmPEaK+1TmIRVqENorzpo0kcHlTsmOnIDfTkMwT4K
         6wsX1PluOv3xVftgIbvqtvyCoNX912YANLjjBxs7V4+JLHlYDAnNUZINoo+8A6gHlY79
         KuVBTl/eJiOLqpUDwLtdAD0O2gCczID3DvHzpAyv3zFHGcAIfof6bYybW1SNypz0fbMr
         vRGrUQTbY5U8NuiNP+3zUN1Ku3GEgMr7tLxkF/trATP/Q9/LEKqcnQOhbMNooh2qgypP
         fNEw==
X-Forwarded-Encrypted: i=1; AJvYcCUI2a/9JknOrUb6/QcHvjbIdoVtw9ga8uwRG7MwU+1rChkxg+NFoGRjMACJCJz+ItdORc6/waI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTclwFyk1rogAASdt3JIkTQAfCFS0dsIh5PYClzF64EWHCeQtu
	rlTRhM2PLCVFz/l2ScJFHAFHac8ks92/ujPHe5kMNp9pywlTVmPGa23yfG1lZeXbqUxxebxR7Zw
	mTjlMP2DYGtiY2Nb+DPCe6xwnuSJrSOZrrsJxBoKp+2vuM5WV52qqVeow+Q==
X-Gm-Gg: ATEYQzwe5H3wQYdAGLYj/IO7dLVFQKom5+9+bJvS2F55z0Qo67NU+uHf3xXDiEIQ37R
	XSfpu9bfBojeUjZe/49zp9IO1NXscsx+yaKToEQCR13WbHT0uN8C1R5npvvpQ5BR63414HFPuty
	CBrFB07wOr8nUy9pSBNracZZRZB0nJymCqYd3bMntkEP84hBshHrKjPjKLsBXSwfHd5XWaVGU/D
	f76w0yNTfXNz2GcCsx8HUSDUrs41PSm8DKdDZqCHDQK+s9nyT1Yv0m2kLOV99t6WzLSw/EjbXtH
	u2dDfORMG6Ptd+JQIqz8AwIiHH3cSoqWeaD5bxI8tUrXOZ/mBcz0FD+Y7CUVe28o/hKmBkAOc+7
	pYVBKRrAk60YVR4XW/BWLhdC4vgd/Vry6Zd3y7+rp6hjWMlcaLw==
X-Received: by 2002:a05:600c:4ecd:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-4853c2dd2e5mr116584345e9.22.1773160725288;
        Tue, 10 Mar 2026 09:38:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecd:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-4853c2dd2e5mr116583875e9.22.1773160724742;
        Tue, 10 Mar 2026 09:38:44 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852470c697sm116693875e9.31.2026.03.10.09.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 09:38:44 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Aaron Conole <aconole@redhat.com>, Ilya Maximets
 <imaximet@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 3/5] selftests: net: rename pmtu.sh to
 pmtu-test.sh
Message-ID: <20260310173842.723df058@elisabeth>
In-Reply-To: <20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Mar 2026 17:38:43 +0100 (CET)
X-Rspamd-Queue-Id: 121F02553D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266245-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu-test.sh:url,pmtu.sh:url,virtuozzo.com:email,psock_snd.sh:url,netns-sysctl.sh:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,netns-name.sh:url,pmtu_run.sh:url,nl_netdev.py:url,reuseport_addr_any.sh:url,reuseaddr_ports_exhausted.sh:url]
X-Rspamd-Action: no action

Nit, only in case this needs a re-spin for whatever reason:

On Mon,  9 Mar 2026 15:20:11 +0000
Aleksei Oladko <aleksey.oladko@virtuozzo.com> wrote:

> Rename the pmtu.sh test script to pmtu-test.sh. No functional
> changes are made, only the file name is updated.

I don't think pmtu-test.sh is very descriptive. I think leaving it as
pmtu.sh and having the new pmtu.sh named pmtu_run.sh would be more
self-explanatory. But it's not a strong preference either way.

> Signed-off-by: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
> ---
>  tools/testing/selftests/net/Makefile                  | 2 +-
>  tools/testing/selftests/net/{pmtu.sh => pmtu-test.sh} | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/net/{pmtu.sh => pmtu-test.sh} (100%)
> 
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 605c54c0e8a3..8fa6ef771757 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -63,7 +63,7 @@ TEST_PROGS := \
>  	netns-name.sh \
>  	netns-sysctl.sh \
>  	nl_netdev.py \
> -	pmtu.sh \
> +	pmtu-test.sh \
>  	psock_snd.sh \
>  	reuseaddr_ports_exhausted.sh \
>  	reuseport_addr_any.sh \
> diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu-test.sh
> similarity index 100%
> rename from tools/testing/selftests/net/pmtu.sh
> rename to tools/testing/selftests/net/pmtu-test.sh

-- 
Stefano


