Return-Path: <netdev+bounces-118718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8219528A2
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FD021F2101C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086B73BB50;
	Thu, 15 Aug 2024 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="1a7tsG/4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FE43147
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723697034; cv=none; b=M6kNE+kLKLKCeS7zgq5BrMMRODjJASYawXUAC3oxeyBIjNsbAj9NtVhYFI3srqqb3ebQ38aZaS6VgxB/ZUlcBa6QZTfVRN7z4KrwJ/fVTSVOEEZHXKI42lsXyRovA/FbHcwaiWljQLosdmhKWWjT7Wir4LwfiCTKy5UTAygpNYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723697034; c=relaxed/simple;
	bh=H1dmmqQ/S+xIgTkmPw34S4k6Pel6uTKhyOIsToQJPG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jk8tWtyFCcFsSQseXk3SQDPq+s3zv60sDfKAn7UBR/0ie5ow7HkMh0b/zuWFmKOs5NbA98C6megjPrU2dFbqC+3Dx+t9H6rKYVyeViAfCvyQugo4VIW3cmPCj/ZKwPmc0xwAm6s0uVWzn0y5xkc78AGddVtrnxklWtdSaf3lu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=1a7tsG/4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-201f2b7fe0dso1369145ad.1
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723697031; x=1724301831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6dssMsdyRNbMyJJES+M0wAnx9TcwUXJlrdWU4Ru46CU=;
        b=1a7tsG/45ZqsWu7CzXQuws/AZe64TqDhUvaZJ9U5ruprlNu9VbzofFLahJ2LMaRKrE
         kgilFsWzRo0wvSgP18Ls3N0C1mvDPVThWmKLb47lsjb60um6NusTFq4B9592bpKC/5eN
         wtdB0dEY12cuwOkUUngw1KbBzyns63s9v/KaAaenQhfLGqlA1SkedlVwRbte3/+WoN2n
         Je92AYZv20R96Hm/obZnwVykytw1ysQrTEMlX4p2m4sxrBK/wJhD59nP7qyJvtO72ngg
         5cUjiTcqf6FSdY19DtYyWYDcMQa7/r2LyEF1guIdLdRPDt4W6hTuTTz4yCKxky+WPOec
         2Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723697031; x=1724301831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dssMsdyRNbMyJJES+M0wAnx9TcwUXJlrdWU4Ru46CU=;
        b=fSmC+S36eMsxpYeHe+NXMQrvsqhHiJGr/8X4ZZeqI1C6CaAyyZfac6NcMPHlHcqebN
         z83/+b5qSeRVuG6gHBJyIsLa8GM7QHri1z+wEY+6Fs0xykg0PuimFR8akcx0KllPNaLP
         FN3qckVUsmjsHUNRbKXjVRsMAi/QW/fd7ISzFyQ1zkgmUnlKHNl1us6FJTY4f/OE6piT
         SRVbqCiMIQ56Q/7qh6cVTNW0uh5wLUXUKYEBe6ZOYvxgJUDleMHO1I7H2IYnvjeZU45D
         Ll6Lh6o1d4N/Amum5+tD1PZ5GN/N2pmrDwZZeDmxT3os0ui9p1bujL1EhG/K+qHrBgBN
         apfw==
X-Gm-Message-State: AOJu0Yz1tu0+98cZc4fl0unZVHJSuHdGbrZbzMaa5C7ZP+XwbxUF+Ldv
	APTHstq3KHK405Q2sa1rhOR87eVa99grwmQ9+UfvZUtu8+j+NeHxWrt0t2Pdiu/VVUpT5czVtSo
	4
X-Google-Smtp-Source: AGHT+IHirdq6XzE6TKwPd7xyMOnQ9ASe1o8l4p+q8ThaBgCVOFn24mvV7ZE/dptmnemnq+8NtnuK8w==
X-Received: by 2002:a17:902:ec8a:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-201d64b1542mr56670305ad.46.1723697031093;
        Wed, 14 Aug 2024 21:43:51 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c5e1sm4017335ad.94.2024.08.14.21.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:43:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFT iproute] ip: fix uninitialized vf number
Date: Wed, 14 Aug 2024 21:42:35 -0700
Message-ID: <20240815044340.32952-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following was found by Gcc 14 analyzer.
The patch is marked RFT since I don't have hardware that does
SR-IOV VF with rate control.

If ip link is used to set up VF and min/max are both not set.
Then the code to get the rate will use an uninitialized vf number.

Full compile output:

iplink.c:497:48: warning: use of uninitialized value ‘tivt.vf’ [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
  497 |                         ipaddr_get_vf_rate(tivt.vf, &tmin, &tmax, dev);
      |                                            ~~~~^~~
  ‘do_iplink’: events 1-6
    |
    | 1419 | int do_iplink(int argc, char **argv)
    |      |     ^~~~~~~~~
    |      |     |
    |      |     (1) entry to ‘do_iplink’
    | 1420 | {
    | 1421 |         if (argc < 1)
    |      |            ~
    |      |            |
    |      |            (2) following ‘false’ branch (when ‘argc > 0’)...
    |......
    | 1424 |         if (matches(*argv, "add") == 0)
    |      |            ~~~~~~~~~~~~~~~~~~~~~~
    |      |            ||
    |      |            |(3) ...to here
    |      |            (4) following ‘true’ branch...
    | 1425 |                 return iplink_modify(RTM_NEWLINK,
    |      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~
    |      |                        |
    |      |                        (5) ...to here
    |      |                        (6) calling ‘iplink_modify’ from ‘do_iplink’
    | 1426 |                                      NLM_F_CREATE|NLM_F_EXCL,
    |      |                                      ~~~~~~~~~~~~~~~~~~~~~~~~
    | 1427 |                                      argc-1, argv+1);
    |      |                                      ~~~~~~~~~~~~~~~
    |
    +--> ‘iplink_modify’: events 7-8
           |
           | 1028 | static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
           |      |            ^~~~~~~~~~~~~
           |      |            |
           |      |            (7) entry to ‘iplink_modify’
           |......
           | 1039 |         ret = iplink_parse(argc, argv, &req, &type);
           |      |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           |      |               |
           |      |               (8) calling ‘iplink_parse’ from ‘iplink_modify’
           |
           +--> ‘iplink_parse’: events 9-11
                  |
                  |  525 | int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
                  |      |     ^~~~~~~~~~~~
                  |      |     |
                  |      |     (9) entry to ‘iplink_parse’
                  |......
                  |  547 |         while (argc > 0) {
                  |      |                ~~~~~~~~
                  |      |                     |
                  |      |                     (10) following ‘true’ branch...
                  |  548 |                 if (strcmp(*argv, "up") == 0) {
                  |      |                     ~~~~~~~~~~~~~~~~~~~
                  |      |                     |
                  |      |                     (11) ...to here
                  |
                ‘iplink_parse’: event 12
                  |
                  |../include/utils.h:53:36:
                  |   53 | #define NEXT_ARG() do { argv++; if (--argc <= 0) incomplete_command(); } while(0)
                  |      |                                    ^
                  |      |                                    |
                  |      |                                    (12) following ‘false’ branch...
iplink.c:555:25: note: in expansion of macro ‘NEXT_ARG’
                  |  555 |                         NEXT_ARG();
                  |      |                         ^~~~~~~~
                  |
                ‘iplink_parse’: events 13-18
                  |
                  |  556 |                         if (name)
                  |      |                            ^
                  |      |                            |
                  |      |                            (13) ...to here
                  |      |                            (14) following ‘false’ branch (when ‘name’ is NULL)...
                  |  557 |                                 duparg("name", *argv);
                  |  558 |                         if (check_ifname(*argv))
                  |      |                            ~~~~~~~~~~~~~~~~~~~~
                  |      |                            ||
                  |      |                            |(15) ...to here
                  |      |                            (16) following ‘false’ branch...
                  |  559 |                                 invarg("\"name\" not a valid ifname", *argv);
                  |  560 |                         name = *argv;
                  |      |                                ~~~~~
                  |      |                                |
                  |      |                                (17) ...to here
                  |  561 |                         if (!dev)
                  |      |                            ~
                  |      |                            |
                  |      |                            (18) following ‘true’ branch (when ‘dev’ is NULL)...
                  |
                ‘iplink_parse’: event 19
                  |
                  |cc1:
                  | (19): ...to here
                  |
                ‘iplink_parse’: events 20-66
                  |
                  |  547 |         while (argc > 0) {
                  |      |                ~~~~~^~~
                  |      |                     |
                  |      |                     (20) following ‘true’ branch...
                  |  548 |                 if (strcmp(*argv, "up") == 0) {
                  |      |                    ~~~~~~~~~~~~~~~~~~~~
                  |      |                    ||
                  |      |                    |(21) ...to here
                  |      |                    (22) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  551 |                 } else if (strcmp(*argv, "down") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(23) ...to here
                  |      |                           (24) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  554 |                 } else if (strcmp(*argv, "name") == 0) {
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |
                  |      |                            (25) ...to here
                  |......
                  |  563 |                 } else if (strcmp(*argv, "index") == 0) {
                  |      |                           ~
                  |      |                           |
                  |      |                           (26) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  570 |                 } else if (matches(*argv, "link") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(27) ...to here
                  |      |                           (28) following ‘false’ branch...
                  |......
                  |  573 |                 } else if (matches(*argv, "address") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(29) ...to here
                  |      |                           (30) following ‘false’ branch...
                  |......
                  |  580 |                 } else if (matches(*argv, "broadcast") == 0 ||
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||                                |
                  |      |                           |(31) ...to here (34) following ‘false’ branch (when the strings are non-equal)...
                  |      |                           (32) following ‘false’ branch...
                  |  581 |                            strcmp(*argv, "brd") == 0) {
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |
                  |      |                            (33) ...to here
                  |......
                  |  588 |                 } else if (matches(*argv, "txqueuelen") == 0 ||
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||                                 |
                  |      |                           |(35) ...to here  (38) following ‘false’ branch (when the strings are non-equal)...
                  |      |                           (36) following ‘false’ branch...
                  |  589 |                            strcmp(*argv, "qlen") == 0 ||
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |                          |
                  |      |                            |                          (40) following ‘false’ branch...
                  |      |                            (37) ...to here
                  |  590 |                            matches(*argv, "txqlen") == 0) {
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |
                  |      |                            (39) ...to here
                  |......
                  |  598 |                 } else if (strcmp(*argv, "mtu") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(41) ...to here
                  |      |                           (42) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  605 |                 } else if (strcmp(*argv, "xdpgeneric") == 0 ||
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||                                |
                  |      |                           |(43) ...to here (46) following ‘false’ branch (when the strings are non-equal)...
                  |      |                           (44) following ‘false’ branch (when the strings are non-equal)...
                  |  606 |                            strcmp(*argv, "xdpdrv") == 0 ||
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |                            |
                  |      |                            |                            (48) following ‘false’ branch (when the strings are non-equal)...
                  |      |                            (45) ...to here
                  |  607 |                            strcmp(*argv, "xdpoffload") == 0 ||
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |                                |
                  |      |                            (47) ...to here (50) following ‘false’ branch (when the strings are non-equal)...
                  |  608 |                            strcmp(*argv, "xdp") == 0) {
                  |      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            |
                  |      |                            (49) ...to here
                  |......
                  |  620 |                 } else if (strcmp(*argv, "netns") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(51) ...to here
                  |      |                           (52) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  634 |                 } else if (strcmp(*argv, "multicast") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(53) ...to here
                  |      |                           (54) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  644 |                 } else if (strcmp(*argv, "allmulticast") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(55) ...to here
                  |      |                           (56) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  654 |                 } else if (strcmp(*argv, "promisc") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(57) ...to here
                  |      |                           (58) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  664 |                 } else if (strcmp(*argv, "trailers") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(59) ...to here
                  |      |                           (60) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  674 |                 } else if (strcmp(*argv, "arp") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(61) ...to here
                  |      |                           (62) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  684 |                 } else if (strcmp(*argv, "carrier") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(63) ...to here
                  |      |                           (64) following ‘false’ branch (when the strings are non-equal)...
                  |......
                  |  693 |                 } else if (strcmp(*argv, "vf") == 0) {
                  |      |                           ~~~~~~~~~~~~~~~~~~~~
                  |      |                           ||
                  |      |                           |(65) ...to here
                  |      |                           (66) following ‘true’ branch (when the strings are equal)...
                  |
                ‘iplink_parse’: event 67
                  |
                  |../include/utils.h:53:29:
                  |   53 | #define NEXT_ARG() do { argv++; if (--argc <= 0) incomplete_command(); } while(0)
                  |      |                         ~~~~^~
                  |      |                             |
                  |      |                             (67) ...to here
iplink.c:696:25: note: in expansion of macro ‘NEXT_ARG’
                  |  696 |                         NEXT_ARG();
                  |      |                         ^~~~~~~~
                  |
                ‘iplink_parse’: event 68
                  |
                  |../include/utils.h:53:36:
                  |   53 | #define NEXT_ARG() do { argv++; if (--argc <= 0) incomplete_command(); } while(0)
                  |      |                                    ^
                  |      |                                    |
                  |      |                                    (68) following ‘false’ branch...
iplink.c:696:25: note: in expansion of macro ‘NEXT_ARG’
                  |  696 |                         NEXT_ARG();
                  |      |                         ^~~~~~~~
                  |
                ‘iplink_parse’: events 69-74
                  |
                  |  697 |                         if (get_integer(&vf,  *argv, 0))
                  |      |                            ~^~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                            ||
                  |      |                            |(69) ...to here
                  |      |                            (70) following ‘false’ branch...
                  |......
                  |  700 |                         vflist = addattr_nest(&req->n, sizeof(*req),
                  |      |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                                  |
                  |      |                                  (71) ...to here
                  |  701 |                                               IFLA_VFINFO_LIST);
                  |      |                                               ~~~~~~~~~~~~~~~~~
                  |  702 |                         if (!dev)
                  |      |                            ~
                  |      |                            |
                  |      |                            (72) following ‘false’ branch (when ‘dev’ is non-NULL)...
                  |......
                  |  705 |                         len = iplink_parse_vf(vf, &argc, &argv, req, dev);
                  |      |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                  |      |                               |
                  |      |                               (73) ...to here
                  |      |                               (74) calling ‘iplink_parse_vf’ from ‘iplink_parse’
                  |
                  +--> ‘iplink_parse_vf’: events 75-76
                         |
                         |  299 | static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
                         |      |            ^~~~~~~~~~~~~~~
                         |      |            |
                         |      |            (75) entry to ‘iplink_parse_vf’
                         |......
                         |  303 |         struct ifla_vf_rate tivt;
                         |      |                             ~~~~
                         |      |                             |
                         |      |                             (76) region created on stack here
                         |
                       ‘iplink_parse_vf’: event 77
                         |
                         |../include/utils.h:54:33:
                         |   54 | #define NEXT_ARG_OK() (argc - 1 > 0)
                         |      |                       ~~~~~~~~~~^~~~
                         |      |                                 |
                         |      |                                 (77) following ‘true’ branch...
iplink.c:333:16: note: in expansion of macro ‘NEXT_ARG_OK’
                         |  333 |         while (NEXT_ARG_OK()) {
                         |      |                ^~~~~~~~~~~
                         |
                       ‘iplink_parse_vf’: event 78
                         |
                         |../include/utils.h:53:29:
                         |   53 | #define NEXT_ARG() do { argv++; if (--argc <= 0) incomplete_command(); } while(0)
                         |      |                         ~~~~^~
                         |      |                             |
                         |      |                             (78) ...to here
iplink.c:334:17: note: in expansion of macro ‘NEXT_ARG’
                         |  334 |                 NEXT_ARG();
                         |      |                 ^~~~~~~~
                         |
                       ‘iplink_parse_vf’: event 79
                         |
                         |../include/utils.h:53:36:
                         |   53 | #define NEXT_ARG() do { argv++; if (--argc <= 0) incomplete_command(); } while(0)
                         |      |                                    ^
                         |      |                                    |
                         |      |                                    (79) following ‘false’ branch...
iplink.c:391:25: note: in expansion of macro ‘NEXT_ARG’
                         |  391 |                         NEXT_ARG();
                         |      |                         ^~~~~~~~
                         |
                       ‘iplink_parse_vf’: events 80-87
                         |
                         |  392 |                         if (get_unsigned(&ivt.rate, *argv, 0))
                         |      |                            ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                         |      |                            ||
                         |      |                            |(80) ...to here
                         |      |                            (81) following ‘false’ branch...
                         |......
                         |  395 |                         ivt.vf = vf;
                         |      |                         ~~~~~~~~~~~
                         |      |                                |
                         |      |                                (82) ...to here
                         |......
                         |  493 |         if (new_rate_api) {
                         |      |            ~
                         |      |            |
                         |      |            (83) following ‘true’ branch (when ‘new_rate_api != 0’)...
                         |......
                         |  496 |                 if (tivt.min_tx_rate == -1 || tivt.max_tx_rate == -1) {
                         |      |                    ~~~~~~~~~~~~~~~~~
                         |      |                    |    |
                         |      |                    |    (84) ...to here
                         |      |                    (85) following ‘true’ branch...
                         |  497 |                         ipaddr_get_vf_rate(tivt.vf, &tmin, &tmax, dev);
                         |      |                                            ~~~~~~~
                         |      |                                                |
                         |      |                                                (86) ...to here
                         |      |                                                (87) use of uninitialized value ‘tivt.vf’ here

Fixes: f89a2a05ffa9 ("Add support to configure SR-IOV VF minimum and maximum Tx rate through ip tool")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---

 ip/iplink.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 3bc75d24..01e51335 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -306,6 +306,7 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 	struct rtattr *vfinfo;
 	int ret;
 
+	tivt.vf = vf;
 	tivt.min_tx_rate = -1;
 	tivt.max_tx_rate = -1;
 
@@ -404,15 +405,11 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 			if (get_unsigned(&tivt.max_tx_rate, *argv, 0))
 				invarg("Invalid \"max tx rate\" value\n",
 				       *argv);
-			tivt.vf = vf;
-
 		} else if (matches(*argv, "min_tx_rate") == 0) {
 			NEXT_ARG();
 			if (get_unsigned(&tivt.min_tx_rate, *argv, 0))
 				invarg("Invalid \"min tx rate\" value\n",
 				       *argv);
-			tivt.vf = vf;
-
 		} else if (matches(*argv, "spoofchk") == 0) {
 			struct ifla_vf_spoofchk ivs;
 
-- 
2.43.0


