Return-Path: <netdev+bounces-209083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C284B0E3A0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 20:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B5B16472F
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A8927FD48;
	Tue, 22 Jul 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5UhMngi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18CF27A90A
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 18:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209888; cv=none; b=NWkROxpLG9LfOhVgQnITTmVYQLSlKdaQH/+duSSjbAwWHbdB3k9DjlZ9RB1SGnnBIXciKnH1aXO0Y6E2693XBDXz4dMH8gz73ZGWT7khAvAMhq3/LIFfmgIgTy3F7MC2BwHjeHdnydSr0weFCYG3dWufFKIoExF+S02ZnkiHWu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209888; c=relaxed/simple;
	bh=itrNcKQhudxlHz6nnxf1jQLZwfWmm8kG7hBtF03s2no=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WGs6VhZK5uuEdHErSMIKt4euZ+T9Wm4qvMkdlpcESyAxFI0X3kEBTY/j9tH5Mdm+jRF29gxrmSw07+D1FdfBEBUDPEfJfkwdzfhSeS5KUl1S9Gn9kKdNt7tcDJZheMKR9sa/9onKjBq6q1fJ+x4+vbxE77fAI0XtZNf/sZznByM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5UhMngi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-454f428038eso50815195e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753209885; x=1753814685; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOTCcA0sVJmWbrWvruuQSxg0FNsXESwarjl9iM7Q4Xc=;
        b=M5UhMngiMjfgGkHUbM08+ANkWEP4gmYiv+XuVHkhfv4GwMGVY6B2jVjDNqr1wfKBF1
         GeZ4uyT1GnhSlHvCZPFbvSeh+qdRbNgjgfY1Ac+jltadJB7MVpQgb7A1JcB5eVN4//9E
         /saoPrnmFhpNikjvOmghGt+crVIa5eE8yRXPyhNDO0pJKT3uhnbpMaeFCiD2OP/3YaTe
         nSz8ybUfRKaTq43KJbHpSInqlEkYlFvCivNMXpceKvN990CSmvyIT/QLxpH3fivZoa67
         7+ZVRreVTOx5WtbOh/u0QV6X8FcU9uwUSNq7GIqnhLrhDypkmSCLqo32av4R+EEZh9RI
         jhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209885; x=1753814685;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOTCcA0sVJmWbrWvruuQSxg0FNsXESwarjl9iM7Q4Xc=;
        b=fSING4x/SydeIRviTp3tZ4+/t4eJqypOngx5RQ7WgsvIj3vTyOQbBAg58+ivAjWMrW
         b6P4VswNQ8vXp77to5Hm5tBisNdbBUldcJRYL38gxUAifpCYUiP0WEsP2+yShAjjDG8V
         TQtvvZz6Jh8UBphhCM3quHYcOw0pcjoXNI2nP9PWgSS8ogkI8rggnxPmzx0ufXUim4yu
         C3ZMO0gnnGhhT7XnNKrP1ml5+bJYWJFQdTQoo0KEQut4uIp7JUa4zG5vmgsahX/lz4T/
         /NUZQxW/Vo80A7HyMBPNiz1rzQWWsUYnwCdL3If+4Lu/FOKZnRlnkd6lTXMssKDKe3QO
         eeAw==
X-Gm-Message-State: AOJu0YxbNWbLiGMhF8sYIOJScdMVZGEl0gqVHqcNS3kGQsjk+4l5lr0I
	8s5ViIS+VOLqQJ49LW/EMv9tXEEoYMbO2LSdFTC7BLvezIs+YXILmRTeWNeU/NMqoS4=
X-Gm-Gg: ASbGncukDiwMaWEUrLqfVcLKgAdDwt/f/ItHXo0E0Y0GZ7zDFzD8t2MehlpG5DknF9q
	3PbAVrgRHictaQ/1h7f+GfLZu70FjtXtRuItTT6USyintBjV4+TJCBC54oKMDnbTeUQZszRol1Y
	Gnb2jJT9aeLCw+JU4y5/9u1KpIFGmu2Rt/RIn51jAfkO3f+BPiPsNRcdcyu45Uo3ZJQoZp7xLrt
	00NoKeh96xp9paFg2U6z5TBvOyijrfz8Ir1rKqOBXVLIrzbSmczkBg+yTAnJWTkiPEVOZDkq9Z1
	HzCO3TGod8xLnn9UJXMCSp3fWRJIS+xg24l1jvjceeNnK1BlyODCVkQAW5ecCAMAzlIwSbJURDf
	iuCa8fH6VlBT8ymqGUxI6ovsfPPe58aiD2jzGzKpViz4NM69lAG6ywhM=
X-Google-Smtp-Source: AGHT+IHP0xxji5zFuwBIjarduysoa3wax/GuTDk9vJdn7+616XTdL3/X4MYusoHJLfSNCEbEt/8Mig==
X-Received: by 2002:a05:6000:4212:b0:3b5:e6bf:8379 with SMTP id ffacd0b85a97d-3b768ef95a4mr263342f8f.28.1753209884766;
        Tue, 22 Jul 2025 11:44:44 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4897bsm14226594f8f.53.2025.07.22.11.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:44:44 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:44:42 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: netdev@vger.kernel.org
Cc: Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: bpf: LLVM BTF inner map struct type def missing
Message-ID: <aH_cGvgC20iD8qs9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

While writing a BPF prog using map of maps I bumped into this compiler
bug that GitHub user thediveo and Isovalent colleague Timo Beckers
already discussed in the cilium/ebpf discussions [^1].

The issue is that a struct only used in a inner map is not included in
the program BTF, so it needs a dummy declaration elsewhere to work.

For example such program:

	#include "vmlinux.h"
	#include <bpf/bpf_helpers.h>

	struct missing_type {
		uint64_t foo;
	};

	// struct missing_type bar; // commented on purpose

	struct {
		__uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
		__type(key, uint32_t);
		__type(value, uint32_t);
		__uint(max_entries, 16);
		__array(
			values, struct {
				__uint(type, BPF_MAP_TYPE_HASH);
				__type(key, uint64_t);
				__type(value, struct missing_type);
				__uint(max_entries, 32);
			});
	} outer_map SEC(".maps");

Then do:

	bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
	clang -target bpf -g -O2 -c prog.c -o prog.o
	bpftool btf dump file prog.o

Will result in:

	[1] PTR '(anon)' type_id=3
	[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
	[3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=12
	[4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
	[5] PTR '(anon)' type_id=6
	[6] TYPEDEF 'uint32_t' type_id=7
	[7] TYPEDEF 'u32' type_id=8
	[8] TYPEDEF '__u32' type_id=9
	[9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
	[10] PTR '(anon)' type_id=11
	[11] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=16
	[12] PTR '(anon)' type_id=13
	[13] STRUCT '(anon)' size=32 vlen=4
		'type' type_id=14 bits_offset=0
		'key' type_id=16 bits_offset=64
		'value' type_id=21 bits_offset=128
		'max_entries' type_id=22 bits_offset=192
	[14] PTR '(anon)' type_id=15
	[15] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
	[16] PTR '(anon)' type_id=17
	[17] TYPEDEF 'uint64_t' type_id=18
	[18] TYPEDEF 'u64' type_id=19
	[19] TYPEDEF '__u64' type_id=20
	[20] INT 'unsigned long long' size=8 bits_offset=0 nr_bits=64 encoding=(none)
	[21] PTR '(anon)' type_id=28
	[22] PTR '(anon)' type_id=23
	[23] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=32
	[24] ARRAY '(anon)' type_id=12 index_type_id=4 nr_elems=0
	[25] STRUCT '(anon)' size=32 vlen=5
		'type' type_id=1 bits_offset=0
		'key' type_id=5 bits_offset=64
		'value' type_id=5 bits_offset=128
		'max_entries' type_id=10 bits_offset=192
		'values' type_id=24 bits_offset=256
	[26] VAR 'outer_map' type_id=25, linkage=global
	[27] DATASEC '.maps' size=0 vlen=1
		type_id=26 offset=0 size=32 (VAR 'outer_map')
	[28] FWD 'missing_type' fwd_kind=struct

You can see that the outer map is [25], with values [24] with type to
[12] thus [13] and then the value of [13] is [21] which points to type
[28]. And [28] is a forward declaration. Thus if we try to load this
program (there's no program but the libbpf error msg is explicit):

	bpftool prog load prog.o /sys/fs/bpf/prog

Output is

	libbpf: map 'outer_map.inner': can't determine value size for type [28]: -22.

Now if you uncomment the commented line in the example (or use this type
in a function as suggested by Timo), the BTF looks like this:

	[1] PTR '(anon)' type_id=3
	[2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
	[3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=12
	[4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
	[5] PTR '(anon)' type_id=6
	[6] TYPEDEF 'uint32_t' type_id=7
	[7] TYPEDEF 'u32' type_id=8
	[8] TYPEDEF '__u32' type_id=9
	[9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
	[10] PTR '(anon)' type_id=11
	[11] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=16
	[12] PTR '(anon)' type_id=13
	[13] STRUCT '(anon)' size=32 vlen=4
		'type' type_id=14 bits_offset=0
		'key' type_id=16 bits_offset=64
		'value' type_id=21 bits_offset=128
		'max_entries' type_id=22 bits_offset=192
	[14] PTR '(anon)' type_id=15
	[15] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
	[16] PTR '(anon)' type_id=17
	[17] TYPEDEF 'uint64_t' type_id=18
	[18] TYPEDEF 'u64' type_id=19
	[19] TYPEDEF '__u64' type_id=20
	[20] INT 'unsigned long long' size=8 bits_offset=0 nr_bits=64 encoding=(none)
	[21] PTR '(anon)' type_id=27
	[22] PTR '(anon)' type_id=23
	[23] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=32
	[24] ARRAY '(anon)' type_id=12 index_type_id=4 nr_elems=0
	[25] STRUCT '(anon)' size=32 vlen=5
		'type' type_id=1 bits_offset=0
		'key' type_id=5 bits_offset=64
		'value' type_id=5 bits_offset=128
		'max_entries' type_id=10 bits_offset=192
		'values' type_id=24 bits_offset=256
	[26] VAR 'outer_map' type_id=25, linkage=global
	[27] STRUCT 'missing_type' size=8 vlen=1
		'foo' type_id=17 bits_offset=0
	[28] VAR 'bar' type_id=27, linkage=global
	[29] DATASEC '.bss' size=0 vlen=1
		type_id=28 offset=0 size=8 (VAR 'bar')
	[30] DATASEC '.maps' size=0 vlen=1
		type_id=26 offset=0 size=32 (VAR 'outer_map')

And then the type [27] exists, loading can now proceed.

I tested it with latest LLVM-project head when writing this e789f8bdf369
("[libc][math] Add Generic Comparison Operations for floating point
types (#144983)").

If you think it's reasonable to fix, I would be interested looking into
this.

[^1]: https://github.com/cilium/ebpf/discussions/1658#discussioncomment-12491339

