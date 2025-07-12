Return-Path: <netdev+bounces-206315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B926B02994
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 08:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7FC5662BC
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81B210F53;
	Sat, 12 Jul 2025 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSHrh7zA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4222201034
	for <netdev@vger.kernel.org>; Sat, 12 Jul 2025 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752302351; cv=none; b=Ip6SPM6gmeWc1jMH+Zpun6B/oYAqnlIyUIehuzISQLBpmSeBZWf7oyqoEaHmFdPv0FIoh5zOpOMMzI/ieFtp19jDjjbD/R9iRjNkLcxPredST5qLwie4Xo4WyJo3aPh2KrjGpko/Ah4eoqyU/+9Y3GwiYf93hHO1+zoOWzmP7RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752302351; c=relaxed/simple;
	bh=vjbNHUUTaz7zE4va/oal7ojPS1+2shN15+YHj8WnCqE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=leO5BPzi+Zb3xNno7akaDfvo2qVZJs9nmlriONdszAlAvwl1rzn78d3vNUIeUJuKaiSIl/JZdnnEwgu/2jyaOT+lcb1EaYzxkiWyo3xCChoOSHdqFqUQw4k8/5RJ0ccauGTdSAhE5l6h/f9rQommBpYNnJBPoDd0jEGpg66cv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSHrh7zA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313f8835f29so4279438a91.3
        for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752302349; x=1752907149; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3VPXvH2mvRAGH9FqPEOFIQeu4GENebxxokQWy9jp6IE=;
        b=xSHrh7zAc/y9qj48h0NUu+6EtLJ7fDEKUxenjXuFVMDtpPCLr1IpkOlM+EgeNu41pD
         l0QCMOSuu/CcTf79H7h9Z4GH3lfz/f+TsZR0/7wLo8P0dQGs7Bb1b4Q1wno7c0ffi6Mv
         yxl7Zd6VXB79p2Eq8MEGvque5EkwUXcoEv6ODjFf3ZM7GNDpMs0wi7/6ZGf/IfRtMYeA
         Q0S92FUrPPdfenRtmeTsQtYeoVyy4+uxYWBx4LyEQD5b/8u9/CWi8y4/JSZIR36sOEaI
         WNcy9DpzT4s1y/XkWwneXD6PNmY+mBAr/eTudCm3GG509LkJosGD+Q23q5v4n8mEW+nK
         7OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752302349; x=1752907149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VPXvH2mvRAGH9FqPEOFIQeu4GENebxxokQWy9jp6IE=;
        b=SoIVIYEUMnWxcmJkZgYUBWcTKquHGJZL96xiWdmuBl0brP+Ebv9KP5xqgOvuutuOqG
         ppq+8bhUWSM7BMcnUjLwAxYhuX8uZG3uVcKoHmXskVBFyST7FFAkLpDzDTwxaSJoobG/
         dOQoy+6dyfGFtdlb/fXNIlT9q1gI10UDgqx3Iszrynhj2rbjw8o7qTBhtvdSEUSrvtEK
         Tq1QKt/JkPPjd0qwjO4S7e0f8f9HYHShuSvFWZoQJVS7/VRNnR/i8VAhcV/7bAx08APl
         xuIPjB7uYOoJzIiO0PzsA2aRCY1u9WpBd0Jlmw8x8PyIM1INy6DLeD7WWklnDdSIst6Y
         lfug==
X-Forwarded-Encrypted: i=1; AJvYcCWy6HCJezKCw77CbQ6qJ7FdDKLaZmLeQJxhhXbbbcxUbtq/F+K8DtLqVuLylgu6ai8dxH/sjRA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Z0kstJR/pbA4vgbDBRMxY5V51ef8FkjZXMctxh7mIQmoh6GM
	P1fOQRbwQt5YX/F3JnEUyWrEhd2cHIYdqAnDW1Rkx9TLIv6NzNT3dv1jkzc0xrV0VccXIJxVyOS
	MlGgc6g==
X-Google-Smtp-Source: AGHT+IEIOANH5eJDmrQy1OghKPpT3RQTtaVUtbEUu6u5Eur5hwe0pTX3yRZ9taAb7uMlnuy4k6GOtuVzdDA=
X-Received: from pjq11.prod.google.com ([2002:a17:90b:560b:b0:2ff:84e6:b2bd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d587:b0:235:27b6:a891
 with SMTP id d9443c01a7336-23dede7d510mr84362825ad.28.1752302349138; Fri, 11
 Jul 2025 23:39:09 -0700 (PDT)
Date: Sat, 12 Jul 2025 06:38:33 +0000
In-Reply-To: <20250712054157.GZ1880847@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250712054157.GZ1880847@ZenIV>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250712063901.3761823-1-kuniyu@google.com>
Subject: Re: [PATCH][RFC] don't bother with path_get()/path_put() in unix_open_file()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sat, 12 Jul 2025 06:41:57 +0100
> Once unix_sock ->path is set, we are guaranteed that its ->path will remain
> unchanged (and pinned) until the socket is closed.  OTOH, dentry_open()
> does not modify the path passed to it.
> 
> IOW, there's no need to copy unix_sk(sk)->path in unix_open_file() - we
> can just pass it to dentry_open() and be done with that.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Sounds good.  I confirmed vfs_open() copies the passed const path ptr.

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>


> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 52b155123985..019ba2609b66 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3191,7 +3191,6 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
>  
>  static int unix_open_file(struct sock *sk)
>  {
> -	struct path path;
>  	struct file *f;
>  	int fd;
>  
> @@ -3201,27 +3200,20 @@ static int unix_open_file(struct sock *sk)
>  	if (!smp_load_acquire(&unix_sk(sk)->addr))
>  		return -ENOENT;
>  
> -	path = unix_sk(sk)->path;
> -	if (!path.dentry)
> +	if (!unix_sk(sk)->path.dentry)
>  		return -ENOENT;
>  
> -	path_get(&path);
> -
>  	fd = get_unused_fd_flags(O_CLOEXEC);
>  	if (fd < 0)
> -		goto out;
> +		return fd;
>  
> -	f = dentry_open(&path, O_PATH, current_cred());
> +	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
>  	if (IS_ERR(f)) {
>  		put_unused_fd(fd);
> -		fd = PTR_ERR(f);
> -		goto out;
> +		return PTR_ERR(f);
>  	}
>  
>  	fd_install(fd, f);
> -out:
> -	path_put(&path);
> -
>  	return fd;
>  }

