Return-Path: <netdev+bounces-173078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D02A571B2
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 20:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0BE172CD9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BF24FBE5;
	Fri,  7 Mar 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Msoxl3r6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFD9194C9E
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741375736; cv=none; b=gQ7UI4Vl9iCsE+0n5FOZbI465YqPF6G6/SgqFvr5ZrujLW8kg+6gpUoTpePC1eVotE6icVNxJArNqc5UeNlfmp///cRp/6xoURnM7nRYNjqc/JBByptaeaqcRXuKxFFoKQP9Ievz+HeuZNRHX3mHEp+lukUjCdYPaZoOSLwUkKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741375736; c=relaxed/simple;
	bh=RTuL8C/cNxVQW6xKmouU/sYGPmXVJsMRETl9voaOrNc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bkvfqWzOJSDqjY8p+JcyONks/zE8pBuB6YH+cDNlnWLgCRoXTntlIxzjteAG1dgXoTYnNidkNfyxMMZQCDYKFyshd6CuWg/nkajwfpQnv52x3VhQTYGv2DIYk9EywfVMiTDKdGfCgGP5QBDye9os7OEJqazJENCgaUk76cqtzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Msoxl3r6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741375734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=s/8eUGBaFppBkdLV49j4JMs3/91SqYHNLdHNfyNt2lE=;
	b=Msoxl3r6HflaeHMWKZhid7EqcFKN5NeQSwDduYjQzEMnmortFc9Gf6rzMJJJcIga4Ph9C2
	chKW6z9JzSscrcv82AZRZRXYAeoA9Kw7iNiVtoqNLbDJvVMAE5cp3k/DxLrcvtNb/FLZVx
	Z+RWg4pZjsDCRm5A197Ayegq8ajDhrw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-065q9ldyMuGYXRSHjuKZ3w-1; Fri, 07 Mar 2025 14:28:53 -0500
X-MC-Unique: 065q9ldyMuGYXRSHjuKZ3w-1
X-Mimecast-MFC-AGG-ID: 065q9ldyMuGYXRSHjuKZ3w_1741375732
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43bce8882d4so10594685e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 11:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741375732; x=1741980532;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s/8eUGBaFppBkdLV49j4JMs3/91SqYHNLdHNfyNt2lE=;
        b=sr2fq2Fo3yyEHkziFfeLmngFMeT52BUqmRHw13YgPkt+RXkwR3RdBDs/NNVcl7cFC3
         WYBHVPO4aNzNkhDJBxYUnQfgUYTt7qkf/XmQpp1KnWMEUF/6ToV56Ypx1VDwBM+r0rq0
         w3PikQB60b1ZX3VTymWIODvorsHqWB2zmRbVbFA8og8Nu4diOn5gqOODn9muYvpqww6r
         5cU7147gCZD4kyQ3XpgHdgFmrb/GfrL04eGHhswX0m9apmpl/HMoBUONq6OfkRztQX7T
         sf8Jc0YYLfVdQ0k4OCIgUfkzyN5EBPMNLLeYMNik2xebqNjzXvZCnYwNbRN/ovPTEzdJ
         mO3A==
X-Gm-Message-State: AOJu0Yx+a+3SoMJwHCdDIU33BzjupIREFBSpR1YsMUjoK/4GSSBp5Zxi
	rs73hW0e4Kj/j2EjxoS5aeoCsXCr6Ol+5iKG3CLy6lybJUHf171W8UCLiQCmfLuPHAd3/8cqcsb
	XcijKVyB0OaAV+KnplxF9Wl1hpktwirNVJT/inbjje020Y5kLuKHCNc/Pkod0qA==
X-Gm-Gg: ASbGncvfEPPzjaE714hZRflZXnqXMA1lbhRKh61dFLs/HDsx/t882PeGwAwlW0IQXzm
	R8quv4UHrdvTS4REeP1t95HeskE/MMOqA5faxousL4IjYEAnXMOPkeN4nMTB3CjcwJQI5JoGrdk
	tkE9n7O51tiLBBxkm6aKQJmv5vD0hg4dToCBwrUDduZOMIATUUerlXF7zxxpzCp+ncpJMoa4cI1
	JRMQ8LLinQD/5ee8sW0qbccbG4tRr08F7zoV/obM5Ifqv9Bw7hk2UegXOcNd40SL6m2seWSItpc
	12fOG3E7y+c0jpAvEVP80vRrGCc2EPsxLn8Xu6//sg9mAE9Y89BSGIwtu4nY4nRWYRsbzV4=
X-Received: by 2002:a05:600c:3b93:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43ce70d47damr522085e9.19.1741375731765;
        Fri, 07 Mar 2025 11:28:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtubqGaTgk93BitRcSyGexQfdjWDbgw9ZlQ/5P0L5SCSa0u25Ja44CQse7Dj/PrgEEZZhv7g==
X-Received: by 2002:a05:600c:3b93:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43ce70d47damr521955e9.19.1741375731369;
        Fri, 07 Mar 2025 11:28:51 -0800 (PST)
Received: from debian (2a01cb058d23d6008552c00d9d2e4ba2.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:8552:c00d:9d2e:4ba2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd93cac5sm60241235e9.27.2025.03.07.11.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 11:28:50 -0800 (PST)
Date: Fri, 7 Mar 2025 20:28:48 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: [PATCH net v4 0/2] gre: Fix regressions in IPv6 link-local address
 generation.
Message-ID: <cover.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

IPv6 link-local address generation has some special cases for GRE
devices. This has led to several regressions in the past, and some of
them are still not fixed. This series fixes the remaining problems,
like the ipv6.conf.<dev>.addr_gen_mode sysctl being ignored and the
router discovery process not being started (see details in patch 1).

To avoid any further regressions, patch 2 adds selftests covering
IPv4 and IPv6 gre/gretap devices with all combinations of currently
supported addr_gen_mode values.

v4: Use lib.sh in the selftest (patch 2).
v3: Rework patch 1's commit message (typos + GRE device types
    clarifications).
v2: Add Makefile entry for the new selftest (patch 2).


Guillaume Nault (2):
  gre: Fix IPv6 link-local address generation.
  selftests: Add IPv6 link-local address generation tests for GRE
    devices.

 net/ipv6/addrconf.c                           |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 177 ++++++++++++++++++
 3 files changed, 187 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


