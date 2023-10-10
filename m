Return-Path: <netdev+bounces-39539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5386A7BFAE5
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF22281B86
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D60119471;
	Tue, 10 Oct 2023 12:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nDFUQOAR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FD119467
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 12:12:17 +0000 (UTC)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4FB99
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QjpGyTnUYim9i7DnAmOa80xufx5NW8Ygz4RPI12CbEs=;
	t=1696939936; x=1698149536; b=nDFUQOARgngkRfiq2+P2X5YSoG73bWBv+Xji9OpNbj6GDEk
	Ix1RYgZL1TcLn12bzhUh+tjDPxj8GlHCojk8Z3vdxKjyP2VXF8eSpYAburOzGeKW6X5IqweXCJyVQ
	PpCXFIZ9wBS3ffD1ihh2aGFPdLqWeSj7ny2D/0VMME31Nn2k42ezqkx7O0KcltBmZFUHJbHDkKqYe
	OwbWsWFq3jhMjfR0/BXOJwNQcuyWHZmd8OEIfR6ODa+4+CEHxNvh48OePQLtf2pYH2ocfAa+3YPK6
	2LWgRAMdtq5WQOQLbiuuhiSRFqw5uVjl/c+Xl1L7BuZOOkZqcHQY2lJpN+F7Xtyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qqBat-00000000MKM-3l8R;
	Tue, 10 Oct 2023 14:12:12 +0200
Message-ID: <cd8c3e791c720eb58f1c6dbba7378f150fb05e41.camel@sipsolutions.net>
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op
 for different cmds into single iter
From: Johannes Berg <johannes@sipsolutions.net>
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com,  jacob.e.keller@intel.com
Date: Tue, 10 Oct 2023 14:12:10 +0200
In-Reply-To: <20231010110828.200709-2-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
	 <20231010110828.200709-2-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 13:08 +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
>=20
> Currently, split ops of doit and dumpit are merged into a single iter
> item when they are subsequent. However, there is no guarantee that the
> dumpit op is for the same cmd as doit op.
>=20
> Fix this by checking if cmd is the same for both.
>=20
> Fixes: b8fd60c36a44 ("genetlink: allow families to use split ops directly=
")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes

