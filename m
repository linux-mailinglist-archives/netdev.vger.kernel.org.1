Return-Path: <netdev+bounces-167788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9DD2A3C508
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 17:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B13A7372
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCEB1FE45B;
	Wed, 19 Feb 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTsu/4pg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9852B1FDA7C
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739982612; cv=none; b=Xloyj/y0/Mz8iFes2bz8M6PIUIebbqTveixVWJ9FsswSWwJSn0LbvCwVpXKKFJYdvl4AsR7fsFll31ueLWZviFkqrax9jhY7k1+I8uu/r2qrC5U9QSJqeNetUBAe2swmat44cYVg7zHk9CUD5daRVYele+hsJ7fR9Z6Sn2jUifw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739982612; c=relaxed/simple;
	bh=PYiAuBl3OgYoZLPRWH9rWLp0Vc5HFkHmQV8/8AOITAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rzVF8dtQEcMuEc0X/72GDE+woRcfDXCM3twTGBM3exC44pSp/nnlPV1dD5qzMq5/r1MidOXaug7keW5GzUjIvSuhTcF4++bDbAFHygWsRQbBQZi1F6b+As6D4NE5eht8zEi85JCci+Qe3/gUUw7g62nrA3wiYSm5/TN+T3qragU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTsu/4pg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739982609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mHcdmCAikD5+nl/Ly1w8RBdUTQdvVqSqO0X1GN2PsQg=;
	b=jTsu/4pg3x1AN98Pl7J7b9V7dXLzLqsKOXlfxzRRN3mprlQjmjO/saUVEPO32F0lSPzgP+
	puytKHKaq+Ro5e6MofAJxwv0B+0HZ1n8NDGmBks67Dw1yUBfH7vhi7hj0rgvnYSZvvrjbj
	5gRKbRs06D329Z+r8bwPfY1pYbLmua0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-DDrqurTnONul9_n5pUCLXw-1; Wed, 19 Feb 2025 11:30:07 -0500
X-MC-Unique: DDrqurTnONul9_n5pUCLXw-1
X-Mimecast-MFC-AGG-ID: DDrqurTnONul9_n5pUCLXw_1739982606
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f36f03312so2169450f8f.3
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 08:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739982606; x=1740587406;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHcdmCAikD5+nl/Ly1w8RBdUTQdvVqSqO0X1GN2PsQg=;
        b=qyDgTRgv2DPXjRjQ8sFcKSJ4pqjzIW+RXeJpOm51dmRPU7j4QORCvs1RmTxtMMAWxp
         s78vLGwwBEbzdCnEnAbR4x1Im/YGgcsP7v8Rir+tnsDRKObarIJL1q+ZDGXZvdwHJ9r3
         uoodzwMmZYl0KzwjuZfBrX1UjKo/nBGwREsn77VZ3foGMhr6BeQCfJYE0PtnlnsIVXgv
         EEf3Ee/fxArSpRTNUmRGIApaalXo2qqLJXVsCMvq2PXSCWcPzdsS4MwWBjXEtwhfcqZT
         HLCoPruVeI4sne9wcc+TJDLxmpTX5C+kIEda9zF0fM72ryOQ8B5/QrpsnFbqvB9R5KfP
         y8vA==
X-Gm-Message-State: AOJu0Yy0q9BDTP8hdTU48Lvr7K+S65+mgfO+W0OUZfae3/Po9zpi61vl
	o/y6aViZDhU2x2pWJsf2DAWcY4rUwn/TwU0kjJu69Mu9p/zNGV4Prq+hRo1FjlHEY5jfgLTCc/T
	VZKKuXZ0u/eCL/IyQDL8QmcLTq5VKhfr5vKG6D7zMAoVVKXRTjsAeRg==
X-Gm-Gg: ASbGncv6/DTc5fu4RsuEexVRzJrANzVhKoi4UC261rRCIWoK/XBEqtrhBTDR82INFlb
	s8TMZKfedcW+5+1SqobYgmASUsHMXrtUJFMQJUc4Xh5XGmZvFNYeaqy2gQEDm7VBLwpgsM7/Npl
	aPlJ75rvbVz383wwLk+WHCgUt2eB2DDukHGDlyT2tWaxlbb+XMvAPZY86PI2oe33uy81wgl446x
	aL23okvFhcy+9wvu/tQqnzar0mIBPT8WMPe77fu2iFi+EMu5eXHYGrCkxiO5xh1I13a
X-Received: by 2002:a05:6000:18a6:b0:38f:4f63:5117 with SMTP id ffacd0b85a97d-38f4f635229mr10027401f8f.39.1739982606382;
        Wed, 19 Feb 2025 08:30:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8zgK60kHrUe0WfA4L4ic7qvh9yNtyoJ/3AUwoxMoKAMPCL4tpXcu7MbJFfiYyynVjUKEWvQ==
X-Received: by 2002:a05:6000:18a6:b0:38f:4f63:5117 with SMTP id ffacd0b85a97d-38f4f635229mr10027364f8f.39.1739982605992;
        Wed, 19 Feb 2025 08:30:05 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258eb141sm17921585f8f.41.2025.02.19.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:30:05 -0800 (PST)
Date: Wed, 19 Feb 2025 17:30:03 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: [PATCH net 0/2] gre: Fix regressions in IPv6 link-local address
 generation.
Message-ID: <cover.1739981312.git.gnault@redhat.com>
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

Guillaume Nault (2):
  gre: Fix IPv6 link-local address generation.
  selftests: Add IPv6 link-local address generation tests for GRE
    devices.

 net/ipv6/addrconf.c                           |  15 +-
 .../testing/selftests/net/gre_ipv6_lladdr.sh  | 227 ++++++++++++++++++
 2 files changed, 236 insertions(+), 6 deletions(-)
 create mode 100755 tools/testing/selftests/net/gre_ipv6_lladdr.sh

-- 
2.39.2


