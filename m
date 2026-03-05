Return-Path: <netdev+bounces-264177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AEjJP0IqWlc0gAAu9opvQ
	(envelope-from <netdev+bounces-264177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:39:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E897420ADCB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199813037E49
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0B4283C9D;
	Thu,  5 Mar 2026 04:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eN3/GMzh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406871DF987
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 04:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685454; cv=pass; b=lT/t4cb/SdMzq6i7f7+GD9+DSklLZ5CzGohZga+/2hoCFUGSy6kQe6uxlRm3OQzR6vHEsdgXEzIqMyZjMYEl4ckEEB55iLxQu5l1GPH8lEsQogHiT0HuZLAXYSJeOHKIsoOnWpnFXyRyuYGtJVc5n1UAf72MoOP3SDcKQhP5s4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685454; c=relaxed/simple;
	bh=vfU/Bhh9KsRHxheqhISjS+BA7M3c+qz1IrFFIpi1qZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+/4uiWzp8OWdTvG1iy8Gu7rZV8XyFv7LLtTak63i7zbfxdzqNPbXeCguSU+oTjZKwHBk9YL2bInszS5GGYPwzFij56tlxke2bhBT4wdJncJqVRE0lAfoBuTKVrnXMCmMIrPqn1+CGFF8Bn1O3EELcdhai94N3nueBObFP2/jSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eN3/GMzh; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1270adc5121so9546241c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 20:37:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685451; cv=none;
        d=google.com; s=arc-20240605;
        b=UP3PAGFudxG6MhfIS53OQC725xhOa2c1VPs3RrbjXimfqQ6ompIUj9BRorSnuU34xI
         fr2uQi5WA3gw/yCnqLdqmMJ5Eplv25usxt0f7awl/8Ac6QM5ruzYBLt3oJkAFNuxq0oE
         x6zkxKojjJ5tXvqGjK+Xi+HeicXJl+BLKkA9eLnTVoe/uqaPbSREqYjlt7jSkB+w1jIA
         yaLY59Z7bfCncOppNnhg6aTyzUCC9eC2WW4bRNjKRwLP4aeGZSfy8Aksm1Ge1kEyJeYD
         1bNsASeNhkIh2iApjy4tOsIp8RcH3waVEYhqrB41VufexXJsAIDceB5cT8Pxc81uDhtH
         IryQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vfU/Bhh9KsRHxheqhISjS+BA7M3c+qz1IrFFIpi1qZM=;
        fh=euZ2mVvNhqZse93jYSZeSfEmlBQeh0UptLpSu4qvZkI=;
        b=DyHNJ8xf2DZyKHOAYkC3Jy9GtwqynuIxiA2hChHhsYfVDm360/7XjXNhNObQiwIyDH
         Ztx0241u9dZt+va208X1VXJEMgDcYlIoR7JjpkIb03tzbKWMje650XPlBIpOOWqn/ZiB
         RbrF9LAaAZtJYpJyWhxK0NcmzH0jqTORE7/7sTB6XExlQQFES2ybvcelViGc6dHIgpS/
         OFphB/gECNN17icqK0Oa6MtsSE9TPKejnAnjgOxIklT6N8wUywdz7h31oretgkoRqa1R
         ZnE3xwtMUYYnd8NC6+G0Wi9Fgqe0rX3RkWQIx5iQUqcT8UCtU3JfoYfDmPZcZOpjtOPB
         rPKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685451; x=1773290251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfU/Bhh9KsRHxheqhISjS+BA7M3c+qz1IrFFIpi1qZM=;
        b=eN3/GMzhGzEeqzXQftDxlV+zBvzqC8xlkNvPynD3ePKSPuSEexkvCKjaa38qqB9wX6
         ToX57vCGuCRxpIfijYIcPST/wm8oTyf7Pd9xQdQ9Ij+IVjJt9LeV+2Ero+ntNLaYIQEw
         X3Yap0EH143Kjgsi1gzzeipWQa5exu5aArNWvoOaNxfxa/dTYQq+txuVM9gvk8rnTFJM
         kjN3j8+sWYunj2l8cW1lBM+Wa0n+kD/5MTkQkSkLKaRNbqFM+DF/xoNqb8csrs2oIT7B
         JkhQeJS2QkSY/HzvD6iTz8VP+Ahvkdoi1S3uUrwNSQgEeKxnf7CXNwyNzqSCh/Nif/Zk
         HDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685451; x=1773290251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfU/Bhh9KsRHxheqhISjS+BA7M3c+qz1IrFFIpi1qZM=;
        b=WcmqmxzcQdqk5X+IvkFg+ATBLwMo3jcQ8Gn7KE7A59I2meqmlh8w44f3lupdzQwynz
         R6vxG8atYiwC9HiSZ3nQfp+saPBE0pVAJoUhUjmr/AiruO8LGxDiehn7nJk06R41Bu8Z
         nJBpMuuloRYmaFIIqDEHjVMHz+6I4nXeNxwFSI9WTXLTRBnI296K90b3iZySknLQ51M2
         nVcrXkls/caVFDKGd+TswMmsuRdiZKLiUGJfJ7psp8n1Eq7eQ5GZk9yy3dg7PbraLb2d
         Mtu0tw53iJ580DARVEkkBXaaVJXO5rw/KnddbNGFXukXGn/WbNQaUrxrtboIA9P4xNBv
         cF2g==
X-Forwarded-Encrypted: i=1; AJvYcCUw1Q3XyhRBLlU1zricVpay2vMHMrxBaR/0mPX+FQNik+3PHC4UGUnfCWQn+D5PMxLT2zZBoMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEYmF9tfDwcLJ13j23lFiyfig4+ZSZcQEhLmQM1lHnR/QVIAFW
	qOo4VLt0kUpoMNzOIlTbI6pl9DKyzzxJTWSRQBsb9icBUxlZ7AXVJQFT6UEqNHRMpzUhg8+CKUG
	CdEF2tFYvz+SCSn5WPInyxjiQetK1gu+tqe3+ah+7GeANVV1bLwBUCc6+
X-Gm-Gg: ATEYQzxwq28iPjjdAHQ/0ZP1UCU8+F9VYQ3PEn8fC5neZTr+ny/n49NrLWIqIO4/XL/
	P6SjTIxZEgUtAkgYCdKEFPmbYWFx+F/XNiDDkF8GG7+3riVeF6DLVWlNcIJ68BE9slfM6nVVYXO
	scwYqdWSnDw0toe/WV88GVWpPj1PwoZz4zxVAkh1TiyuxqdaUzqOUk+K8IsSskMlTVr5FwoTecR
	L5ewl18n0zJNDbKLru/0EDGM69J/MkhrfMuOOzDxEvdftnfZwy6zyEBgLedBRDHqSFqDPwqvBio
	EMqrpRhPRQqhEryrM3GES4ow7g6OUCGy/W4YA5dUCczUrLy3DufvFvm+DQgc5w/XYH0mjJzf
X-Received: by 2002:a05:7022:6999:b0:123:3364:2ca8 with SMTP id
 a92af1059eb24-128b70f83d6mr1636311c88.39.1772685450830; Wed, 04 Mar 2026
 20:37:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305022703.3946470-1-kmta1236@gmail.com>
In-Reply-To: <20260305022703.3946470-1-kmta1236@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 20:37:19 -0800
X-Gm-Features: AaiRm50Po2nsFsFpf1PT478fE4wiji5kkRYCFOmAbdXu_Z7Csu9829kIMrwk7tQ
Message-ID: <CAAVpQUC8Oiy53MG08tR1OXGgJSWse1nSLFhUdJtVzSvc-qsB-w@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unused hash_size from struct tcp_out_options
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E897420ADCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 6:27=E2=80=AFPM Keita Morisaki <kmta1236@gmail.com> =
wrote:
>
> hash_size is declared but never read. The MD5 path always uses a
> fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Keita Morisaki <kmta1236@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

