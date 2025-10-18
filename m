Return-Path: <netdev+bounces-230678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB5BBED25A
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0E43E34A09C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E11B87C0;
	Sat, 18 Oct 2025 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="WoqNj1vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59043AA6
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760800678; cv=none; b=cx/MOEwlqRazK3LdzqVxfH1GpDvSefh0o980cFPf1BMF0YJ84WMV1ac2i7IPtBiMGNtlcAepWOdbd2i0Gr+/sVPi32Ge+Gzk0Cyq/SpBnIh6XFgvYiW1lLB2syOLvtPgyzmJO+Xc3sPpQwfzcc8chxoKGDHrJLK4sg5jcNNOPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760800678; c=relaxed/simple;
	bh=x6/C+W0ev66cJOkQGcDArPIfHmcYnap34xevhw4XIHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AW0jOLp36YHQIEtPdGTS8voatXfB9r/I82q0ETGGoBCq1S2d+kF1vIAiuATp4AtdvvlHXmWUqDZXiT+iQuNibWZDHJhUWiEoB8BUXePrwylGx8HVTD5Blg6Z4ys280efQKdIvVYMrtkezuqkCjqWLxWkXvblxsMCOH5TsQf0Dmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=WoqNj1vv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b403bb7843eso526040166b.3
        for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1760800675; x=1761405475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ew9YL3RtLpgvCJCr95BVG1hvaIAcGvrHDBjaFRKpI44=;
        b=WoqNj1vvmuCiUNsEi3WwqOeZt1Q8YtiNYqaVcDuThJ9Z6KYtXZRnU6TvdHhApAotqQ
         uXgo+cBZirgY31QWXOUJdYZh0CTDCimbGfIMGv1FoZ6+zHq5CjT/q/PmdzBij/3ajFDx
         t9LlgNKmSl7wCNtzVvFbMfoJpIRUGfDgGOsDGitm7NtVsMGGZXU309HisZq3S/CMTPxu
         kOLBT3sLaiYzp0y97xlKePFsyZ9Ia4hGnl7RfZ/Pz6nu6038degb+mb08FU25Krg6gIb
         /sTdgngdzJlVochtw2l0QYd+I0Amc1wQj1rcwa5OymBOxXmyLGQF8Ml8VFmPuNk69sG+
         N3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760800675; x=1761405475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew9YL3RtLpgvCJCr95BVG1hvaIAcGvrHDBjaFRKpI44=;
        b=STDuwYhgAyuMGx/ixIbfe2dU5UmhgWQJA/yjO2kEu2vx6BOEg5NO25FOo5w/gb45CL
         F5VeRHaakiIDCFlUPlhBA+vsRQUHT6h5a2zH3CQdqKVe3u7eAmCRLZZGCp+boGsmf3zo
         87Fg+zjk9HkR5pOSuJcuaBaKwO93PBkCbxbt7C5R6l4+KgAdnmFM21NPhLt2Z2TjkoLr
         b0pKqlzAksa3l+/QVBrKehHHfZKgVFfcRhIKhbs/EDxOqhPJ3DgtJam1IX88qgMZ0RxO
         qnf1dvIfFOz/x+EII7QCGRaJd66tzwIV8ZqE3jIPs6NwJY/lk0xKgDCDWJJCsMzZL7YE
         iLVA==
X-Forwarded-Encrypted: i=1; AJvYcCWxd8xeHXfqexPspLUxzEWQQwL8Rq4UI7iqO4XkoJ1R8hXYw8EfzRgvZ7RLYMyKEQFGl9htlQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy98D76hCdOmnHos5bzA9Hzk0Ij/2/c8UOMAkxWtRYjQyeA8IkB
	GxLgXKtK0vdmA0xZ7X+7tkR7X/MyWN5A9qU2a+TdM4C9hZUUnQMTToGM
X-Gm-Gg: ASbGncsjXg6hUUK1PiDSrf6QU7AjlU8XEuq30HJDkln+0PsTIHZhrEO+MJ3QczKs5fq
	5GmTlG64Ctbt3yHJavXPVYMolbfaICqSQdvJxJv4hKffvZ9xUx6Z+FiEjWhy4UTiIeKUW/ypR0x
	XQN8b+ly9W79smINvZ3Ydq6EGnSTM0U52m+4ueueWmsQGl1k2wlSqqW8xApKX7g24NhPu92VEju
	VaHyPBrv9b7mObdDRwoAT0WLg0KeYRVUiPu62dXp0hSpVDhfGsDuEh5Pt0wO2VxfOr8Rg/dvsaU
	3aBbzHrKl4+zNsp9oRt8b+eDl8LEiEG0+tLmv1wUrzrXfKjSc0z6sislU42380q5IxhexW4NSyw
	oLeayQ7d8/qMNcgSqDeEL0PxrefrDTsaZ+lLLFG867Xr1Bx0MoqzS1VGpM3lg2XNmX+PUkAdnVP
	RLGjeyXAibgKy0uHnyVUGIpEeqDk6dXXAe17ZQ18e7KbA7qyIFFPCUT6/VTfJ3JLg=
X-Google-Smtp-Source: AGHT+IEw2BzaFoZ9fFDkZJgW0JYRl3LByJCBHqcBzxe0EifgHlnwJtpG8O//r2K45ZSIzB3CABQVQA==
X-Received: by 2002:a17:907:7f21:b0:b04:2ee1:8e2 with SMTP id a640c23a62f3a-b6473b4eb20mr769376766b.36.1760800675263;
        Sat, 18 Oct 2025 08:17:55 -0700 (PDT)
Received: from tycho (p200300c1c7311b00ba8584fffebf2b17.dip0.t-ipconnect.de. [2003:c1:c731:1b00:ba85:84ff:febf:2b17])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036846sm259983366b.54.2025.10.18.08.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 08:17:54 -0700 (PDT)
Sender: Zahari Doychev <zahari.doychev@googlemail.com>
From: Zahari Doychev <zahari.doychev@linux.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	ast@fiberby.net,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	johannes@sipsolutions.net,
	zahari.doychev@linux.com
Subject: [PATCH 0/4] tools: ynl: Fix tc filters with actions
Date: Sat, 18 Oct 2025 17:17:33 +0200
Message-ID: <20251018151737.365485-1-zahari.doychev@linux.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch in this series introduces an example tool that
creates a flower filter with two VLAN actions. The subsequent
patches address various issues to ensure the tool operates as
intended.

Zahari Doychev (4):
  ynl: samples: add tc filter add example
  tools: ynl: zero-initialize struct ynl_sock memory
  tools: ynl: call nested attribute free function for indexed arrays
  tools: ynl: add start-index property for indexed arrays

 Documentation/netlink/netlink-raw.yaml | 13 ++++
 Documentation/netlink/specs/tc.yaml    |  7 ++
 tools/net/ynl/Makefile.deps            |  1 +
 tools/net/ynl/lib/ynl.c                |  2 +-
 tools/net/ynl/pyynl/lib/nlspec.py      |  1 +
 tools/net/ynl/pyynl/ynl_gen_c.py       | 18 ++++-
 tools/net/ynl/samples/.gitignore       |  1 +
 tools/net/ynl/samples/tc-filter-add.c  | 92 ++++++++++++++++++++++++++
 8 files changed, 133 insertions(+), 2 deletions(-)
 create mode 100644 tools/net/ynl/samples/tc-filter-add.c

-- 
2.51.0


