Return-Path: <netdev+bounces-191100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6575ABA0FF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE73188500F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006901C6FFA;
	Fri, 16 May 2025 16:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcciLv8C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C232CCC1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747414036; cv=none; b=W2PIpCpBo4lrfoZ+g565rL5W0iJd412koxUMpoCssRUqQpqK+D65FASqnXU0XYBqxjKdO3TkHQnippvugxUeahqH7GJazl1SxTVKmpgGGPtQ4fmiaqAiOLRqecrrrTOrkazZRtAcS8dblSExbf0mA/feDytwHtNW6HQwtpnXQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747414036; c=relaxed/simple;
	bh=ZD7K0dYd0F2zMQPabdQGNUMke0WDH0cZ9yTtQuQscbA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KaorAXG7hCof9wf5CN7VqAKx0W4RcXZzCDaAmutKJ+TBbltZZn06Mlnf0WraQJOocToqpHarXY/C5v8aGdO8gs0GJsLBSAHXHIOlhiQV1oIuXMc4ruBNd+BMxideXVLGD01ua5X2Boduw9ezn+n8Js4olIRiP83q70lryYz/ors=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcciLv8C; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f535b11824so21586946d6.2
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747414034; x=1748018834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYGcFJ1MFAxTVNT3VdJ1JhcbbBc/qKta+bpNIZdljQY=;
        b=dcciLv8CDjRinCWerSnoIK1Lt8ZNlP2XZGOlqkjK75yi3WbTmpIHQphXCcpfudxLTl
         RXasiPEADFlSVmtUWHbpd8InwD/6RAFanqTaONPK3WOkIPE4vh7qSD3YxCM5SD92ohPd
         UTSh4+X8oJUG2uFBUYNV/f6sWV7OYjGzNw/vG1pogmEU57tTBDSVBp1McRmDUVt+dYX1
         Z6tUIxFKnBJ60Qc1ByW+gLefGjbjiagd1p29XEnC9os9FSxpI4+qzagP5RYoprapx5tZ
         y1gOhFsEBJR8I2fn5tFp6qYjQzUk34VriB8WNdAReNiVnauDCiBEM98+9vjb0ZNzr28l
         0UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747414034; x=1748018834;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zYGcFJ1MFAxTVNT3VdJ1JhcbbBc/qKta+bpNIZdljQY=;
        b=rO9WvY1AVwPxg9qwLJbx4bPC1ktkghS6EVHOcNgMN6yUVLFDVfVUSFVWmTA/31Xn29
         2HkEZ92CxwtHGxuzs31dkuTh4pBXSqrhRnpchjp9Uw76KqhP1lNFztJDNlcB/uN+hofa
         l30lIZgygHvyI9WRZl4AARB3Ikh3oTWk12Gb6a+k2QZH45dDo7SNz78cdQ98vcGsMGsm
         aPAv+wZ/YYYIjgNaFeyxK3UZcYG2sAgZrk14kFFFbQ+jea85fg8iGZV9s1Bz75pJN7um
         IHW6yIg6FypImC8QIANnj+r5vpv2aFofGIs0I05XFlUS3l6j4VRjN1AT442FtWaGFoMh
         h4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8bWBJ8PnPLzc81JTkIsewHTMKRdT6a1OsE2npzkZxg6GD0iAtKpssbJ/kmkRGGf2UI1aGsbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUUOh54+epdcwyEHwctzj+mEXQB00ZyU0PTlTOn4R1h8KnCsk
	dG6yWL2sQGdazch6THVLLqzZ9ZGvLEZ3y6oWG5Z2AsLLQ+9h4D0ZgUNA
X-Gm-Gg: ASbGncvNyy7bbsWnlWUZltPhyIuBMhk2X8iu8eARIe7Z3plQ0omCXgObHtgPdus7k4t
	1lJqHB3HXNTPFT2ODPSPKVdSoMxgcsynz1itUdi5lw6Xewa2Xr9UHBfJe4Ma73c4Lqz4BQlsoeH
	tQb6m31y3lhnFAAGSZ/yDwdazw00ir1e+K3xjgl6QU+BgNwJb15AOHrlFM/0uk2FB3NXnzDoamA
	H97eR3q2tfRyDa3KbocEi3DO9E50+atECAvptWbes1HLjd9ZRROPvK+gvWBccyNkg58zqrr4a93
	eeb5/fhLh/aHdF7Ep46awiOGdbdr6DtXtvc586D/ysGgMSmEL20kyRXMtzzL3i+yX5p1PTlPAXk
	T+RzqM14pIo5Sdc7lwpfdfiU=
X-Google-Smtp-Source: AGHT+IHt+eiFwEz56ng4PnFQfdMsvUAvUhfhovaiEovc1JCpDRre5JPK5YvcZxAwBi1tWo908LJg5Q==
X-Received: by 2002:a05:6214:20c7:b0:6f8:923a:d5a9 with SMTP id 6a1803df08f44-6f8b05d7417mr72031356d6.0.1747414034051;
        Fri, 16 May 2025 09:47:14 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0883ed6sm14035026d6.18.2025.05.16.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:47:13 -0700 (PDT)
Date: Fri, 16 May 2025 12:47:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <68276c1118d32_2b92fe29428@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250515224946.6931-8-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
 <20250515224946.6931-8-kuniyu@amazon.com>
Subject: Re: [PATCH v4 net-next 7/9] af_unix: Inherit sk_flags at connect().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> For SOCK_STREAM embryo sockets, the SO_PASS{CRED,PIDFD,SEC} options
> are inherited from the parent listen()ing socket.
> 
> Currently, this inheritance happens at accept(), because these
> attributes were stored in sk->sk_socket->flags and the struct socket
> is not allocated until accept().
> 
> This leads to unintentional behaviour.
> 
> When a peer sends data to an embryo socket in the accept() queue,
> unix_maybe_add_creds() embeds credentials into the skb, even if
> neither the peer nor the listener has enabled these options.
> 
> If the option is enabled, the embryo socket receives the ancillary
> data after accept().  If not, the data is silently discarded.
> 
> This conservative approach works for SO_PASS{CRED,PIDFD,SEC}, but
> would not for SO_PASSRIGHTS; once an SCM_RIGHTS with a hung file
> descriptor was sent, it'd be game over.

Code LGTM, hence my Reviewed-by.

Just curious: could this case be handled in a way that does not
require receivers explicitly disabling a dangerous default mode?

IIUC the issue is the receiver taking a file reference using fget_raw
in scm_fp_copy from __scm_send, and if that is the last ref, it now
will hang the receiver process waiting to close this last ref?

If so, could the unwelcome ref be detected at accept, and taken from
the responsibility of this process? Worst case, assigned to some
zombie process.

