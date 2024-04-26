Return-Path: <netdev+bounces-91731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F438B3A38
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 982A91C23F2D
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 14:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3B413A257;
	Fri, 26 Apr 2024 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBWXwU58"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EB41DFFC
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714142417; cv=none; b=lduQjdj9Mc6d1IYhooPFtz8Ynlee8GoXxiF7p9+TPxsPiLkRrD/+xbfNVWdqSkVAn77/KxlonUoh8juYgCLBeU+Uwq1H/rjbxUzcyv0pKTp4Yc+Btslgst1bjzaQ9i5QX3QbNDwrnWnBILMrJsKixkpIygQ0g+vuKIXL6r90BQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714142417; c=relaxed/simple;
	bh=VvxdI7fDwZbvesPaEYqb+OTtSJRr8j9O5xAOkuIAbWM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s10Z+AhGLyocEjQDvmwZehuDSRzC5VR/AsDcfOA4Ub+DniUp3vvE7QL1fz6P7XW8W1FsRHeW7OErjcwMZ0O6fXxhb2aN5RZkbXgO+zQw+7RSdZCXk8era+05XBS3WJQJBBG2VbtNAbIzFHuk/YxNPQaNrYna/5AL/3ie2whPWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBWXwU58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FDDC2BD11;
	Fri, 26 Apr 2024 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714142416;
	bh=VvxdI7fDwZbvesPaEYqb+OTtSJRr8j9O5xAOkuIAbWM=;
	h=Date:From:To:Cc:Subject:From;
	b=SBWXwU586yVBATJwea83rK6+9AXH7Lux83f63iJyxEQLYoE8HTAL9rI+CYuLvzzYO
	 0aOjaelAw9wGmYRXTwr7OtcNXZVRci2unaDhqZXqirLFNAxcvStorFFgpIOk7NBg1a
	 WcajRnHM3TdRM1COtcbTgs3e9k/nAZjQ2gDWzz+oTpAFbZ9AW5zQXcY/j6Qi23LPlb
	 yu7ZeW9h2CYRZSKLxGGBpiQwLx6na2Udwv4xxY9knY2osjjULX60Ee0XYA8nqyKw84
	 jUI22cqE542WQtWwYTzWM3TB5hHZpnwX9zuQ6FJ6IZtFdrXq8nQlJVDCHpho75x6Mc
	 p6wcprOEkYV1w==
Date: Fri, 26 Apr 2024 07:40:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] test_bridge_neigh_suppress.sh now failing in both configs
Message-ID: <20240426074015.251854d4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ido, Hangbin Liu,

test_bridge_neigh_suppress.sh has always been failing on debug kernels:

# Per-port ARP suppression - VLAN 10
# ----------------------------------
# TEST: arping                                                        [FAIL]
# TEST: ARP suppression                                               [ OK ]
# TEST: "neigh_suppress" is on                                        [ OK ]
# TEST: arping                                                        [FAIL]
# TEST: ARP suppression                                               [ OK ]
# TEST: FDB entry installation                                        [ OK ]
# TEST: arping                                                        [FAIL]
# TEST: ARP suppression                                               [ OK ]
# TEST: Neighbor entry installation                                   [ OK ]
# TEST: arping                                                        [FAIL]
# TEST: ARP suppression                                               [ OK ]
# TEST: H2 down                                                       [ OK ]
# TEST: arping                                                        [FAIL]
...

after we forwarded the trees to Linus's branch on Thu it's now also
failing on non-debug kernel, in the same way. It fails every time
for us, so should be easy to repro. If you find some spare cycles,
could you take a look?

