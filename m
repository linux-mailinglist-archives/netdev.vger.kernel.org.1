Return-Path: <netdev+bounces-118976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ACA953C50
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C930FB21017
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362213C906;
	Thu, 15 Aug 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KF+6DTij"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6803A14D6F7;
	Thu, 15 Aug 2024 21:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756024; cv=none; b=sdjcz+y/yA2lYwbz6U8+U2O6YlTnUMLGUpeYEegdXk2b7ccM6voUf4njfeQ07IjCf0kQgB+VnpCBoAHYmaCHcI9I4E6lEG9F7VOnLHRhlvL2OjyOswLVin0qIBZqjDxEetOCJvRdUjpfoJa57/xCwuGHm85OEDOtdThFEOb5DwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756024; c=relaxed/simple;
	bh=QXfFtN1BsmswvCojdV2csbPlHcJf+cJa4JsbPOkF2kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AL4rMJ6aYgGD36KNwbOJIWXZY174GdV77e/FgSPpzJmKdbD4STw9sFe63+EMI/hkj32N7izdYrQiIt9vX9doA+UzEhR0j2cdDeoOXv+GKGuoHihiA3QlbGdB/agOW9Ton//XFTe8NfFtuXz05496PWcjTYQm/cOOtzGNyvsKOHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KF+6DTij; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a0e8b76813so1084563a12.3;
        Thu, 15 Aug 2024 14:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723756023; x=1724360823; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V48Wr0IIhhVXIm69mkIjOf3YoA/jzx/O16VrgqQDB6g=;
        b=KF+6DTijcY9xb9V2E7CBqE1XqnzF+hZBuRYAESF7l7mjmtWaGEpHZGmsulgmtO6wGr
         H7hqTjVmLjJtwSsWN5kMswb/wUT/hwjiisGUENcg8LnwvteJCEd88G+Ni/lXgSVw10+x
         Mbfzud7rNFbt57JESns9N88OghcsU+Ff2Vxs/pPsK8Io1PpR0lIvB1erqgWn65/JHyVN
         /+nKfStTem2rCW67K0XbvgNGfFUniWpVxzlUpcGUOVHqidOWrFJnml29QvE0BZHKBQd5
         xTj39VgYta90Z3722H3gXciS8kB+wymSOhHksbn8pqDdbslVvgxvTpcujbRa7DQDOnHD
         6Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723756023; x=1724360823;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V48Wr0IIhhVXIm69mkIjOf3YoA/jzx/O16VrgqQDB6g=;
        b=lYRnuB/SGuQr30v/qttxqN1SDKYPQmyO3KVVia1KKchLMAGScdRXTVALHd/4r0LMoN
         mZBDBWIFPXXl1JptKElq2myPYSJm0eGFgGK8DgiMh5ZH+VIzjKbJ8LwLYp4WdJOJMKM3
         /Oazh2hi/8q3mPZpNtxcWNUC4R9K06aaRiXZp7BfU18uLBqy9oQon8g1ElXwVj6hxtz/
         xM+FKGo1lCNlzpEHA0+OIQT7SuJJ+kzYIsd2wPfixTnJggVwJupB48Qm0joXc1IrAhEk
         AzrVsMn/UNzelQrdaS09WjKh8hqrfS0T1lxFgkQWgQDZtx+9+NQRmLKbKzot82JocyIR
         KLSw==
X-Forwarded-Encrypted: i=1; AJvYcCWA50d/jNVmJbS4rdH4tIguyKG1HAY4N/PiTfEaUDYCmDb5kbTgPfwy2K1Fh9qZs+dgTj1E491boxs/vh2L7RndQUw3lEX3GSmMFtKNIzFLFNDxpYDH9lHLTH4HZq39o8sYFXcs9b/+PML1vZv0mEwR/qzTpQgd4Hp8Pc1cjEGMq5YrjBebwxVQhgu7
X-Gm-Message-State: AOJu0YwXl9OUWA9+Toxvc0YPCWfIwODp6Fe5lFp5Qyey9EtdK6bmCRAi
	j8YLGA/YTIx/zLvDXfwTwVCGAhems41Vh8NZz9c5jwRxsma33w4wfGHYrJL4
X-Google-Smtp-Source: AGHT+IGh1YHSPqb56p+peb4akPQFKMN2+6jiRRiwp9J+XB9gflzZK/w330tQKVoLgcVNtjwBnDVo7Q==
X-Received: by 2002:a17:90a:a787:b0:2cb:3306:b2cc with SMTP id 98e67ed59e1d1-2d3dfc2aa4amr1131428a91.1.1723756022474;
        Thu, 15 Aug 2024 14:07:02 -0700 (PDT)
Received: from tahera-OptiPlex-5000 ([136.159.49.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2b64e7bsm266093a91.9.2024.08.15.14.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:07:02 -0700 (PDT)
Date: Thu, 15 Aug 2024 15:07:00 -0600
From: Tahera Fahimi <fahimitahera@gmail.com>
To: outreachy@lists.linux.dev
Cc: mic@digikod.net, gnoack@google.com, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	bjorn3_gh@protonmail.com, jannh@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3 6/6] Landlock: Document LANDLOCK_SCOPED_SIGNAL
Message-ID: <Zr5t9NbA/RiXtHSN@tahera-OptiPlex-5000>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <193b5874eab4dca132ae3c71d44adfc21022a0ad.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <193b5874eab4dca132ae3c71d44adfc21022a0ad.1723680305.git.fahimitahera@gmail.com>

On Thu, Aug 15, 2024 at 12:29:25PM -0600, Tahera Fahimi wrote:
> Improving Landlock ABI version 6 to support signal scoping
> with LANDLOCK_SCOPED_SIGNAL.
> 
> Signed-off-by: Tahera Fahimi <fahimitahera@gmail.com>
> ---
> v3:
> - update date
> ---
>  Documentation/userspace-api/landlock.rst | 25 +++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
> index 0582f93bd952..01e4d50851af 100644
> --- a/Documentation/userspace-api/landlock.rst
> +++ b/Documentation/userspace-api/landlock.rst
> @@ -8,7 +8,7 @@ Landlock: unprivileged access control
>  =====================================
>  
>  :Author: Mickaël Salaün
> -:Date: July 2024
> +:Date: August 2024
>  
>  The goal of Landlock is to enable to restrict ambient rights (e.g. global
>  filesystem or network access) for a set of processes.  Because Landlock
> @@ -82,7 +82,8 @@ to be explicit about the denied-by-default access rights.
>              LANDLOCK_ACCESS_NET_BIND_TCP |
>              LANDLOCK_ACCESS_NET_CONNECT_TCP,
>          .scoped =
> -            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET,
> +            LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
> +            LANDLOCK_SCOPED_SIGNAL,
>      };
>  
>  Because we may not know on which kernel version an application will be
> @@ -123,7 +124,8 @@ version, and only use the available subset of access rights:
>          ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
>      case 5:
>          /* Removes LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET for ABI < 6 */
> -        ruleset_attr.scoped &= ~LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET;
> +        ruleset_attr.scoped &= ~(LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET |
> +                                 LANDLOCK_SCOPED_SIGNAL);
>      }
>  
>  This enables to create an inclusive ruleset that will contain our rules.
> @@ -319,11 +321,15 @@ interactions between sandboxes. Each Landlock domain can be explicitly scoped
>  for a set of actions by specifying it on a ruleset. For example, if a sandboxed
>  process should not be able to :manpage:`connect(2)` to a non-sandboxed process
>  through abstract :manpage:`unix(7)` sockets, we can specify such restriction
> -with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``.
> +with ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``. Moreover, if a sandboxed process
> +should not be able to send a signal to a non-sandboxed process, we can specify
> +this restriction with ``LANDLOCK_SCOPED_SIGNAL``.
>  
>  A sandboxed process can connect to a non-sandboxed process when its domain is
>  not scoped. If a process's domain is scoped, it can only connect to sockets
> -created by processes in the same scoped domain.
> +created by processes in the same scoped domain. Moreover, If a process is
> +scoped to send signal to a non-scoped process, it can only send signals to
> +processes in the same scoped domain.
>  
>  IPC scoping does not support Landlock rules, so if a domain is scoped, no rules
>  can be added to allow accessing to a resource outside of the scoped domain.
> @@ -563,12 +569,17 @@ earlier ABI.
>  Starting with the Landlock ABI version 5, it is possible to restrict the use of
>  :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
>  
> +<<<<<<< current
>  Abstract UNIX sockets Restriction  (ABI < 6)
>  --------------------------------------------
> +=======
> +Abstract Unix sockets and Signal Restriction  (ABI < 6)
> +-------------------------------------------------------
> +>>>>>>> patched
Sorry about this part. I will correct it. 
>  With ABI version 6, it is possible to restrict connection to an abstract Unix socket
> -through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET``, thanks to the ``scoped`` ruleset
> -attribute.
> +through ``LANDLOCK_SCOPED_ABSTRACT_UNIX_SOCKET`` and sending signal through
> +``LANDLOCK_SCOPED_SIGNAL``, thanks to the ``scoped`` ruleset attribute.
>  
>  .. _kernel_support:
>  
> -- 
> 2.34.1
> 

