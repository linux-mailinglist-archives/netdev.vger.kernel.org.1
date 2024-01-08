Return-Path: <netdev+bounces-62410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020B826FDF
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 779EE1C226B9
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 13:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADB541743;
	Mon,  8 Jan 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkMyOcfI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6444C80
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28bd9ca247so169545066b.1
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 05:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720635; x=1705325435; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KU86wQlorv9vipSPaAXGM5VKE3sVGpb5MAncvsQoT7o=;
        b=IkMyOcfI6ywvslavauQTi1TBSbKmtQB2laELqFdgmdN32JDbGAVq85nz9ZdYTXvba7
         U6ByMSsWjrjC50bcO87CrpEzrWgV/M/jglQbzCp70IXhILRGIelIspd8IUEV2ub2nYkS
         GhIjz33UmmLqdjci7y1mXOiKN4Gn+dK02oQkalzgYLT1NWnqD+JIMfDiDpIIvJBwMlvT
         HrLWwkxyz9HgPbWlkZQtHaUvJfCbIKTcXtTws8diDZoW2sONHVmqBZUxgzZk5KjzR84Z
         WFBUwCc+iUe9/6v3DHrQBwf7X47OdN4q03YbmT+546wG+KXVU5OQiHB2jPA0GubqCAOQ
         Wc7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720635; x=1705325435;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KU86wQlorv9vipSPaAXGM5VKE3sVGpb5MAncvsQoT7o=;
        b=tQLzOPcXdeHUDS9j9CXFzVopSgRHa/ShtoOZikI8QiTuRQ0fWBiVuQaCRpCqhHeisv
         OsbJbrSHk+pgYFB+0PxnIMwuANAhRd9tgJN7xkNvXH7WRhrz+j+dP+Ib4X+dClMKXxgt
         SeHWLfcDnVNauZKrMbGNJPRlLVe2jucrEiMMf7bFbjS8nJrFBuzYsVx7kTNemGs6mlpR
         kaptAWFMoF5USX6NGFS8Jvl5ODxcRQ+C6AguG6sZEiuv9NCFodzLt6piLzoF2tvucrNg
         ElEuG1m3AdauL/AS8EnH4PDt4wg1zUmXrpVdWFJVFEB9oJohBPFXHvHNnG7rbzUH74Ye
         WR1g==
X-Gm-Message-State: AOJu0YzgoNl1wvVhsjaaul4cr95/m34umOCqjF8CPS1L3U+Gu2V58Pr/
	dIPmMcknopuV1Y+WpEIYCaRUGOIzBGmNNA==
X-Google-Smtp-Source: AGHT+IHi0Jc2SeT+xq55FK672IwoshPTTdPtaEE4b7d67NrB1nycJC593QdSfjpG4AXZdsfN/P0ysw==
X-Received: by 2002:a17:906:6b90:b0:a29:dcbd:55bc with SMTP id l16-20020a1709066b9000b00a29dcbd55bcmr1542093ejr.126.1704720633786;
        Mon, 08 Jan 2024 05:30:33 -0800 (PST)
Received: from smtpclient.apple ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b00a2714f1ba8asm3906623ejb.160.2024.01.08.05.30.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2024 05:30:33 -0800 (PST)
From: Martin Zaharinov <micron10@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Kernel 6.7.0 intel i40e driver not build
Message-Id: <21BBD62A-F874-4E42-B347-93087EEA8126@gmail.com>
Date: Mon, 8 Jan 2024 15:30:21 +0200
To: anthony.l.nguyen@intel.com,
 netdev <netdev@vger.kernel.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi Tony Nguyen ,


Please check make error .
This is build of latest kernel 6.7.0 :



  CALL    scripts/checksyscalls.sh
  CC [M]  drivers/net/ethernet/intel/i40e/i40e_ethtool.o
  CC [M]  drivers/net/ethernet/intel/i40e/i40e_diag.o
In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
                 from drivers/net/ethernet/intel/i40e/i40e_diag.c:4:
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown =
type name '__le16'
   33 |         __le16 flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown =
type name '__le16'
   34 |         __le16 opcode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:35:9: error: unknown =
type name '__le16'
   35 |         __le16 datalen;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:36:9: error: unknown =
type name '__le16'
   36 |         __le16 retval;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:37:9: error: unknown =
type name '__le32'
   37 |         __le32 cookie_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:38:9: error: unknown =
type name '__le32'
   38 |         __le32 cookie_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:41:25: error: unknown =
type name '__le32'
   41 |                         __le32 param0;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:42:25: error: unknown =
type name '__le32'
   42 |                         __le32 param1;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:43:25: error: unknown =
type name '__le32'
   43 |                         __le32 param2;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:44:25: error: unknown =
type name '__le32'
   44 |                         __le32 param3;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:47:25: error: unknown =
type name '__le32'
   47 |                         __le32 param0;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:48:25: error: unknown =
type name '__le32'
   48 |                         __le32 param1;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:49:25: error: unknown =
type name '__le32'
   49 |                         __le32 addr_high;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:50:25: error: unknown =
type name '__le32'
   50 |                         __le32 addr_low;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:52:17: error: unknown =
type name 'u8'
   52 |                 u8 raw[16];
      |                 ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:314:9: error: unknown =
type name '__le32'
  314 |         __le32 rom_ver;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:315:9: error: unknown =
type name '__le32'
  315 |         __le32 fw_build;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:316:9: error: unknown =
type name '__le16'
  316 |         __le16 fw_major;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:317:9: error: unknown =
type name '__le16'
  317 |         __le16 fw_minor;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:318:9: error: unknown =
type name '__le16'
  318 |         __le16 api_major;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:319:9: error: unknown =
type name '__le16'
  319 |         __le16 api_minor;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_version' is not an =
integer constant
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:326:9: error: unknown =
type name 'u8'
  326 |         u8      driver_major_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:327:9: error: unknown =
type name 'u8'
  327 |         u8      driver_minor_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:328:9: error: unknown =
type name 'u8'
  328 |         u8      driver_build_ver;
      |         ^~
In file included from drivers/net/ethernet/intel/i40e/i40e_diag.h:7,
                 from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:7:
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:33:9: error: unknown =
type name '__le16'
   33 |         __le16 flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:34:9: error: unknown =
type name '__le16'
   34 |         __le16 opcode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:35:9: error: unknown =
type name '__le16'
   35 |         __le16 datalen;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:36:9: error: unknown =
type name '__le16'
   36 |         __le16 retval;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:37:9: error: unknown =
type name '__le32'
   37 |         __le32 cookie_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:38:9: error: unknown =
type name '__le32'
   38 |         __le32 cookie_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:41:25: error: unknown =
type name '__le32'
   41 |                         __le32 param0;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:42:25: error: unknown =
type name '__le32'
   42 |                         __le32 param1;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:43:25: error: unknown =
type name '__le32'
   43 |                         __le32 param2;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:44:25: error: unknown =
type name '__le32'
   44 |                         __le32 param3;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:47:25: error: unknown =
type name '__le32'
   47 |                         __le32 param0;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:329:9: error: unknown =
type name 'u8'
  329 |         u8      driver_subbuild_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:330:9: error: unknown =
type name 'u8'
  330 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:48:25: error: unknown =
type name '__le32'
   48 |                         __le32 param1;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:49:25: error: unknown =
type name '__le32'
   49 |                         __le32 addr_high;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:50:25: error: unknown =
type name '__le32'
   50 |                         __le32 addr_low;
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:52:17: error: unknown =
type name 'u8'
   52 |                 u8 raw[16];
      |                 ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:314:9: error: unknown =
type name '__le32'
  314 |         __le32 rom_ver;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:315:9: error: unknown =
type name '__le32'
  315 |         __le32 fw_build;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:316:9: error: unknown =
type name '__le16'
  316 |         __le16 fw_major;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:317:9: error: unknown =
type name '__le16'
  317 |         __le16 fw_minor;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:318:9: error: unknown =
type name '__le16'
  318 |         __le16 api_major;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:319:9: error: unknown =
type name '__le16'
  319 |         __le16 api_minor;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_version' is not an =
integer constant
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:322:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  322 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:326:9: error: unknown =
type name 'u8'
  326 |         u8      driver_major_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:327:9: error: unknown =
type name 'u8'
  327 |         u8      driver_minor_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:328:9: error: unknown =
type name 'u8'
  328 |         u8      driver_build_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:329:9: error: unknown =
type name 'u8'
  329 |         u8      driver_subbuild_ver;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:330:9: error: unknown =
type name 'u8'
  330 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:331:9: error: unknown =
type name '__le32'
  331 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:332:9: error: unknown =
type name '__le32'
  332 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:331:9: error: unknown =
type name '__le32'
  331 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:332:9: error: unknown =
type name '__le32'
  332 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_driver_version' is not =
an integer constant
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:339:9: error: unknown =
type name '__le32'
  339 |         __le32  driver_unloading;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:341:9: error: unknown =
type name 'u8'
  341 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_driver_version' is not =
an integer constant
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:335:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  335 | I40E_CHECK_CMD_LENGTH(i40e_aqc_driver_version);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:339:9: error: unknown =
type name '__le32'
  339 |         __le32  driver_unloading;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_queue_shutdown' is not =
an integer constant
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:341:9: error: unknown =
type name 'u8'
  341 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:348:9: error: unknown =
type name 'u8'
  348 |         u8      pf_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:349:9: error: unknown =
type name 'u8'
  349 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_queue_shutdown' is not =
an integer constant
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:344:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  344 | I40E_CHECK_CMD_LENGTH(i40e_aqc_queue_shutdown);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:348:9: error: unknown =
type name 'u8'
  348 |         u8      pf_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_pf_context' is not =
an integer constant
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:349:9: error: unknown =
type name 'u8'
  349 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:358:9: error: unknown =
type name '__le16'
  358 |         __le16  resource_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:359:9: error: unknown =
type name '__le16'
  359 |         __le16  access_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:360:9: error: unknown =
type name '__le32'
  360 |         __le32  timeout;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:361:9: error: unknown =
type name '__le32'
  361 |         __le32  resource_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:362:9: error: unknown =
type name 'u8'
  362 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_pf_context' is not =
an integer constant
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:352:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  352 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_pf_context);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:358:9: error: unknown =
type name '__le16'
  358 |         __le16  resource_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:359:9: error: unknown =
type name '__le16'
  359 |         __le16  access_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:360:9: error: unknown =
type name '__le32'
  360 |         __le32  timeout;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:361:9: error: unknown =
type name '__le32'
  361 |         __le32  resource_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_request_resource' is =
not an integer constant
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:362:9: error: unknown =
type name 'u8'
  362 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:371:9: error: unknown =
type name 'u8'
  371 |         u8 command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:372:9: error: unknown =
type name 'u8'
  372 |         u8 pf_index;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:373:9: error: unknown =
type name 'u8'
  373 |         u8 reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:374:9: error: unknown =
type name '__le32'
  374 |         __le32 count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:375:9: error: unknown =
type name '__le32'
  375 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:376:9: error: unknown =
type name '__le32'
  376 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_request_resource' is =
not an integer constant
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:365:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  365 | I40E_CHECK_CMD_LENGTH(i40e_aqc_request_resource);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:371:9: error: unknown =
type name 'u8'
  371 |         u8 command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:372:9: error: unknown =
type name 'u8'
  372 |         u8 pf_index;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:373:9: error: unknown =
type name 'u8'
  373 |         u8 reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:374:9: error: unknown =
type name '__le32'
  374 |         __le32 count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:375:9: error: unknown =
type name '__le32'
  375 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:376:9: error: unknown =
type name '__le32'
  376 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_list_capabilites' is =
not an integer constant
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:382:9: error: unknown =
type name '__le16'
  382 |         __le16  id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:383:9: error: unknown =
type name 'u8'
  383 |         u8      major_rev;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:384:9: error: unknown =
type name 'u8'
  384 |         u8      minor_rev;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:385:9: error: unknown =
type name '__le32'
  385 |         __le32  number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:386:9: error: unknown =
type name '__le32'
  386 |         __le32  logical_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_list_capabilites' is =
not an integer constant
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  379 | I40E_CHECK_CMD_LENGTH(i40e_aqc_list_capabilites);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:387:9: error: unknown =
type name '__le32'
  387 |         __le32  phys_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:382:9: error: unknown =
type name '__le16'
  382 |         __le16  id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:388:9: error: unknown =
type name 'u8'
  388 |         u8      reserved[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:383:9: error: unknown =
type name 'u8'
  383 |         u8      major_rev;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:384:9: error: unknown =
type name 'u8'
  384 |         u8      minor_rev;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:425:9: error: unknown =
type name '__le16'
  425 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:385:9: error: unknown =
type name '__le32'
  385 |         __le32  number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:426:9: error: unknown =
type name '__le16'
  426 |         __le16  ttlx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:386:9: error: unknown =
type name '__le32'
  386 |         __le32  logical_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:427:9: error: unknown =
type name '__le32'
  427 |         __le32  dmacr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:387:9: error: unknown =
type name '__le32'
  387 |         __le32  phys_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:428:9: error: unknown =
type name '__le16'
  428 |         __le16  dmcth;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:388:9: error: unknown =
type name 'u8'
  388 |         u8      reserved[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:429:9: error: unknown =
type name 'u8'
  429 |         u8      hptc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:425:9: error: unknown =
type name '__le16'
  425 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:430:9: error: unknown =
type name 'u8'
  430 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:426:9: error: unknown =
type name '__le16'
  426 |         __le16  ttlx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:431:9: error: unknown =
type name '__le32'
  431 |         __le32  pfltrc;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:427:9: error: unknown =
type name '__le32'
  427 |         __le32  dmacr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:428:9: error: unknown =
type name '__le16'
  428 |         __le16  dmcth;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:429:9: error: unknown =
type name 'u8'
  429 |         u8      hptc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:430:9: error: unknown =
type name 'u8'
  430 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:431:9: error: unknown =
type name '__le32'
  431 |         __le32  pfltrc;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_cppm_configuration' is =
not an integer constant
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:438:9: error: unknown =
type name '__le16'
  438 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:439:9: error: unknown =
type name '__le16'
  439 |         __le16  table_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:440:9: error: unknown =
type name '__le32'
  440 |         __le32  enabled_offloads;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:441:9: error: unknown =
type name '__le32'
  441 |         __le32  ip_addr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_cppm_configuration' is =
not an integer constant
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:434:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  434 | I40E_CHECK_CMD_LENGTH(i40e_aqc_cppm_configuration);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:442:9: error: unknown =
type name 'u8'
  442 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:438:9: error: unknown =
type name '__le16'
  438 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:443:9: error: unknown =
type name 'u8'
  443 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:439:9: error: unknown =
type name '__le16'
  439 |         __le16  table_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:440:9: error: unknown =
type name '__le32'
  440 |         __le32  enabled_offloads;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:446:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  446 | I40E_CHECK_STRUCT_LEN(0x14, i40e_aqc_arp_proxy_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:441:9: error: unknown =
type name '__le32'
  441 |         __le32  ip_addr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:442:9: error: unknown =
type name 'u8'
  442 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:446:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_arp_proxy_data' is not =
an integer constant
  446 | I40E_CHECK_STRUCT_LEN(0x14, i40e_aqc_arp_proxy_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:443:9: error: unknown =
type name 'u8'
  443 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:450:9: error: unknown =
type name '__le16'
  450 |         __le16  table_idx_mac_addr_0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:451:9: error: unknown =
type name '__le16'
  451 |         __le16  table_idx_mac_addr_1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:446:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  446 | I40E_CHECK_STRUCT_LEN(0x14, i40e_aqc_arp_proxy_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:452:9: error: unknown =
type name '__le16'
  452 |         __le16  table_idx_ipv6_0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:446:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_arp_proxy_data' is not =
an integer constant
  446 | I40E_CHECK_STRUCT_LEN(0x14, i40e_aqc_arp_proxy_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:453:9: error: unknown =
type name '__le16'
  453 |         __le16  table_idx_ipv6_1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:450:9: error: unknown =
type name '__le16'
  450 |         __le16  table_idx_mac_addr_0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:454:9: error: unknown =
type name '__le16'
  454 |         __le16  control;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:451:9: error: unknown =
type name '__le16'
  451 |         __le16  table_idx_mac_addr_1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:455:9: error: unknown =
type name 'u8'
  455 |         u8      mac_addr_0[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:452:9: error: unknown =
type name '__le16'
  452 |         __le16  table_idx_ipv6_0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:456:9: error: unknown =
type name 'u8'
  456 |         u8      mac_addr_1[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:453:9: error: unknown =
type name '__le16'
  453 |         __le16  table_idx_ipv6_1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:457:9: error: unknown =
type name 'u8'
  457 |         u8      local_mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:454:9: error: unknown =
type name '__le16'
  454 |         __le16  control;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:458:9: error: unknown =
type name 'u8'
  458 |         u8      ipv6_addr_0[16]; /* Warning! spec specifies BE =
byte order */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:455:9: error: unknown =
type name 'u8'
  455 |         u8      mac_addr_0[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:459:9: error: unknown =
type name 'u8'
  459 |         u8      ipv6_addr_1[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:456:9: error: unknown =
type name 'u8'
  456 |         u8      mac_addr_1[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:457:9: error: unknown =
type name 'u8'
  457 |         u8      local_mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:462:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  462 | I40E_CHECK_STRUCT_LEN(0x3c, i40e_aqc_ns_proxy_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:458:9: error: unknown =
type name 'u8'
  458 |         u8      ipv6_addr_0[16]; /* Warning! spec specifies BE =
byte order */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:459:9: error: unknown =
type name 'u8'
  459 |         u8      ipv6_addr_1[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:462:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_ns_proxy_data' is not =
an integer constant
  462 | I40E_CHECK_STRUCT_LEN(0x3c, i40e_aqc_ns_proxy_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:466:9: error: unknown =
type name '__le16'
  466 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:462:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  462 | I40E_CHECK_STRUCT_LEN(0x3c, i40e_aqc_ns_proxy_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:467:9: error: unknown =
type name 'u8'
  467 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:462:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_ns_proxy_data' is not =
an integer constant
  462 | I40E_CHECK_STRUCT_LEN(0x3c, i40e_aqc_ns_proxy_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:468:9: error: unknown =
type name '__le32'
  468 |         __le32  sal;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:466:9: error: unknown =
type name '__le16'
  466 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:469:9: error: unknown =
type name '__le16'
  469 |         __le16  sah;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:467:9: error: unknown =
type name 'u8'
  467 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:470:9: error: unknown =
type name 'u8'
  470 |         u8      reserved2[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:468:9: error: unknown =
type name '__le32'
  468 |         __le32  sal;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:469:9: error: unknown =
type name '__le16'
  469 |         __le16  sah;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:470:9: error: unknown =
type name 'u8'
  470 |         u8      reserved2[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mng_laa' is not an =
integer constant
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:477:9: error: unknown =
type name '__le16'
  477 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:480:9: error: unknown =
type name 'u8'
  480 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mng_laa' is not an =
integer constant
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:473:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  473 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mng_laa);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:481:9: error: unknown =
type name '__le32'
  481 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:477:9: error: unknown =
type name '__le16'
  477 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:482:9: error: unknown =
type name '__le32'
  482 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:480:9: error: unknown =
type name 'u8'
  480 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:481:9: error: unknown =
type name '__le32'
  481 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:482:9: error: unknown =
type name '__le32'
  482 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_read' is =
not an integer constant
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:488:9: error: unknown =
type name 'u8'
  488 |         u8 pf_lan_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:489:9: error: unknown =
type name 'u8'
  489 |         u8 pf_san_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_read' is =
not an integer constant
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:485:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  485 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:490:9: error: unknown =
type name 'u8'
  490 |         u8 port_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:488:9: error: unknown =
type name 'u8'
  488 |         u8 pf_lan_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:491:9: error: unknown =
type name 'u8'
  491 |         u8 pf_wol_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:489:9: error: unknown =
type name 'u8'
  489 |         u8 pf_san_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:494:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  494 | I40E_CHECK_STRUCT_LEN(24, i40e_aqc_mac_address_read_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:490:9: error: unknown =
type name 'u8'
  490 |         u8 port_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:491:9: error: unknown =
type name 'u8'
  491 |         u8 pf_wol_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:494:27: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_read_data' =
is not an integer constant
  494 | I40E_CHECK_STRUCT_LEN(24, i40e_aqc_mac_address_read_data);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:494:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  494 | I40E_CHECK_STRUCT_LEN(24, i40e_aqc_mac_address_read_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:498:9: error: unknown =
type name '__le16'
  498 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:505:9: error: unknown =
type name '__le16'
  505 |         __le16  mac_sah;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:494:27: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_read_data' =
is not an integer constant
  494 | I40E_CHECK_STRUCT_LEN(24, i40e_aqc_mac_address_read_data);
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:506:9: error: unknown =
type name '__le32'
  506 |         __le32  mac_sal;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:498:9: error: unknown =
type name '__le16'
  498 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:507:9: error: unknown =
type name 'u8'
  507 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:505:9: error: unknown =
type name '__le16'
  505 |         __le16  mac_sah;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:506:9: error: unknown =
type name '__le32'
  506 |         __le32  mac_sal;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:507:9: error: unknown =
type name 'u8'
  507 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_write' is =
not an integer constant
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:516:9: error: unknown =
type name 'u8'
  516 |         u8      rx_cnt;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:517:9: error: unknown =
type name 'u8'
  517 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_mac_address_write' is =
not an integer constant
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:510:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  510 | I40E_CHECK_CMD_LENGTH(i40e_aqc_mac_address_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:516:9: error: unknown =
type name 'u8'
  516 |         u8      rx_cnt;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:517:9: error: unknown =
type name 'u8'
  517 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_clear_pxe' is not an =
integer constant
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      |                       ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:525:9: error: unknown =
type name '__le16'
  525 |         __le16 filter_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:527:9: error: unknown =
type name '__le16'
  527 |         __le16 cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:528:9: error: unknown =
type name '__le16'
  528 |         __le16 valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:529:9: error: unknown =
type name 'u8'
  529 |         u8 reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:530:9: error: unknown =
type name '__le32'
  530 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_clear_pxe' is not an =
integer constant
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      |                       ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:520:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  520 | I40E_CHECK_CMD_LENGTH(i40e_aqc_clear_pxe);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:531:9: error: unknown =
type name '__le32'
  531 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:525:9: error: unknown =
type name '__le16'
  525 |         __le16 filter_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:527:9: error: unknown =
type name '__le16'
  527 |         __le16 cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:528:9: error: unknown =
type name '__le16'
  528 |         __le16 valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_wol_filter' is not =
an integer constant
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:529:9: error: unknown =
type name 'u8'
  529 |         u8 reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:537:9: error: unknown =
type name 'u8'
  537 |         u8 filter[128];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:538:9: error: unknown =
type name 'u8'
  538 |         u8 mask[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:530:9: error: unknown =
type name '__le32'
  530 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:541:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  541 | I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:531:9: error: unknown =
type name '__le32'
  531 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:541:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_wol_filter_data' =
is not an integer constant
  541 | I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:546:9: error: unknown =
type name 'u8'
  546 |         u8 reserved_1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:547:9: error: unknown =
type name '__le16'
  547 |         __le16 wake_reason;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:548:9: error: unknown =
type name 'u8'
  548 |         u8 reserved_2[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_wol_filter' is not =
an integer constant
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:534:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  534 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_wol_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:537:9: error: unknown =
type name 'u8'
  537 |         u8 filter[128];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_wake_reason_completion' is not an =
integer constant
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:559:9: error: unknown =
type name '__le16'
  559 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:538:9: error: unknown =
type name 'u8'
  538 |         u8 mask[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:560:9: error: unknown =
type name 'u8'
  560 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:561:9: error: unknown =
type name '__le32'
  561 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:541:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  541 | I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:562:9: error: unknown =
type name '__le32'
  562 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:541:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_wol_filter_data' =
is not an integer constant
  541 | I40E_CHECK_STRUCT_LEN(0x90, i40e_aqc_set_wol_filter_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:546:9: error: unknown =
type name 'u8'
  546 |         u8 reserved_1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_switch_seid' is not an =
integer constant
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:571:9: error: unknown =
type name '__le16'
  571 |         __le16  num_reported;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:547:9: error: unknown =
type name '__le16'
  547 |         __le16 wake_reason;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:572:9: error: unknown =
type name '__le16'
  572 |         __le16  num_total;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:573:9: error: unknown =
type name 'u8'
  573 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:548:9: error: unknown =
type name 'u8'
  548 |         u8 reserved_2[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_config_header_resp' is not an =
integer constant
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:579:9: error: unknown =
type name 'u8'
  579 |         u8      element_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:580:9: error: unknown =
type name 'u8'
  580 |         u8      revision;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_wake_reason_completion' is not an =
integer constant
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:551:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  551 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_wake_reason_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:581:9: error: unknown =
type name '__le16'
  581 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:582:9: error: unknown =
type name '__le16'
  582 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:559:9: error: unknown =
type name '__le16'
  559 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:583:9: error: unknown =
type name '__le16'
  583 |         __le16  downlink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:584:9: error: unknown =
type name 'u8'
  584 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:560:9: error: unknown =
type name 'u8'
  560 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:585:9: error: unknown =
type name 'u8'
  585 |         u8      connection_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:586:9: error: unknown =
type name '__le16'
  586 |         __le16  scheduler_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:561:9: error: unknown =
type name '__le32'
  561 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:587:9: error: unknown =
type name '__le16'
  587 |         __le16  element_info;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:562:9: error: unknown =
type name '__le32'
  562 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:590:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  590 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_config_element_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:590:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_switch_config_element_resp' is not an =
integer constant
  590 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_config_element_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:601:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  601 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_switch_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:601:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_config_resp' is not an integer =
constant
  601 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_switch_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:607:9: error: unknown =
type name '__le16'
  607 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_switch_seid' is not an =
integer constant
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:565:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  565 | I40E_CHECK_CMD_LENGTH(i40e_aqc_switch_seid);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:608:9: error: unknown =
type name '__le16'
  608 |         __le16  vlan;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:571:9: error: unknown =
type name '__le16'
  571 |         __le16  num_reported;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:609:9: error: unknown =
type name '__le16'
  609 |         __le16  stat_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:610:9: error: unknown =
type name 'u8'
  610 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:572:9: error: unknown =
type name '__le16'
  572 |         __le16  num_total;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:573:9: error: unknown =
type name 'u8'
  573 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_remove_statistics' =
is not an integer constant
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:617:9: error: unknown =
type name '__le16'
  617 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:618:9: error: unknown =
type name '__le16'
  618 |         __le16  bad_frame_vsi;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:619:9: error: unknown =
type name '__le16'
  619 |         __le16  default_seid;        /* reserved for command */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:620:9: error: unknown =
type name 'u8'
  620 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_config_header_resp' is not an =
integer constant
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:576:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  576 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_config_header_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:579:9: error: unknown =
type name 'u8'
  579 |         u8      element_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:580:9: error: unknown =
type name 'u8'
  580 |         u8      revision;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:581:9: error: unknown =
type name '__le16'
  581 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_port_parameters' =
is not an integer constant
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:582:9: error: unknown =
type name '__le16'
  582 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:627:9: error: unknown =
type name 'u8'
  627 |         u8      num_entries;         /* reserved for command */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:628:9: error: unknown =
type name 'u8'
  628 |         u8      reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:583:9: error: unknown =
type name '__le16'
  583 |         __le16  downlink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:629:9: error: unknown =
type name '__le32'
  629 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:584:9: error: unknown =
type name 'u8'
  584 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:630:9: error: unknown =
type name '__le32'
  630 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:585:9: error: unknown =
type name 'u8'
  585 |         u8      connection_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:586:9: error: unknown =
type name '__le16'
  586 |         __le16  scheduler_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:587:9: error: unknown =
type name '__le16'
  587 |         __le16  element_info;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_resource_alloc' is not an =
integer constant
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:637:9: error: unknown =
type name 'u8'
  637 |         u8      resource_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:590:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  590 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_config_element_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:638:9: error: unknown =
type name 'u8'
  638 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:639:9: error: unknown =
type name '__le16'
  639 |         __le16  guaranteed;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:640:9: error: unknown =
type name '__le16'
  640 |         __le16  total;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:590:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_switch_config_element_resp' is not an =
integer constant
  590 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_config_element_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:641:9: error: unknown =
type name '__le16'
  641 |         __le16  used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:642:9: error: unknown =
type name '__le16'
  642 |         __le16  total_unalloced;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:643:9: error: unknown =
type name 'u8'
  643 |         u8      reserved2[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:601:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  601 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_switch_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:646:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  646 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_resource_alloc_element_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:601:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_config_resp' is not an integer =
constant
  601 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_switch_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:646:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_switch_resource_alloc_element_resp' is not =
an integer constant
  646 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_resource_alloc_element_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:650:9: error: unknown =
type name '__le16'
  650 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:607:9: error: unknown =
type name '__le16'
  607 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:653:9: error: unknown =
type name '__le16'
  653 |         __le16  valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:608:9: error: unknown =
type name '__le16'
  608 |         __le16  vlan;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:659:9: error: unknown =
type name '__le16'
  659 |         __le16  switch_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:667:9: error: unknown =
type name '__le16'
  667 |         __le16  first_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:609:9: error: unknown =
type name '__le16'
  609 |         __le16  stat_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:668:9: error: unknown =
type name '__le16'
  668 |         __le16  second_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:610:9: error: unknown =
type name 'u8'
  610 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:689:9: error: unknown =
type name 'u8'
  689 |         u8      mode;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:690:9: error: unknown =
type name 'u8'
  690 |         u8      rsvd5[5];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_remove_statistics' =
is not an integer constant
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:613:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  613 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_statistics);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:617:9: error: unknown =
type name '__le16'
  617 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_switch_config' is =
not an integer constant
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:618:9: error: unknown =
type name '__le16'
  618 |         __le16  bad_frame_vsi;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:701:9: error: unknown =
type name '__le32'
  701 |         __le32 reserved1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:619:9: error: unknown =
type name '__le16'
  619 |         __le16  default_seid;        /* reserved for command */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:702:9: error: unknown =
type name '__le32'
  702 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:620:9: error: unknown =
type name 'u8'
  620 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:703:9: error: unknown =
type name '__le32'
  703 |         __le32 reserved2;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:704:9: error: unknown =
type name '__le32'
  704 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:720:9: error: unknown =
type name '__le16'
  720 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:721:9: error: unknown =
type name 'u8'
  721 |         u8      connection_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:723:9: error: unknown =
type name 'u8'
  723 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_port_parameters' =
is not an integer constant
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:623:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  623 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_port_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:724:9: error: unknown =
type name 'u8'
  724 |         u8      vf_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:725:9: error: unknown =
type name 'u8'
  725 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:627:9: error: unknown =
type name 'u8'
  627 |         u8      num_entries;         /* reserved for command */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:726:9: error: unknown =
type name '__le16'
  726 |         __le16  vsi_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:628:9: error: unknown =
type name 'u8'
  628 |         u8      reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:730:9: error: unknown =
type name '__le32'
  730 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:731:9: error: unknown =
type name '__le32'
  731 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:629:9: error: unknown =
type name '__le32'
  629 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:630:9: error: unknown =
type name '__le32'
  630 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_get_update_vsi' is =
not an integer constant
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:737:9: error: unknown =
type name '__le16'
  737 |         __le16 seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:738:9: error: unknown =
type name '__le16'
  738 |         __le16 vsi_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:739:9: error: unknown =
type name '__le16'
  739 |         __le16 vsi_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_switch_resource_alloc' is not an =
integer constant
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:633:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  633 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_switch_resource_alloc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:740:9: error: unknown =
type name '__le16'
  740 |         __le16 vsi_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:637:9: error: unknown =
type name 'u8'
  637 |         u8      resource_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:741:9: error: unknown =
type name '__le32'
  741 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:742:9: error: unknown =
type name '__le32'
  742 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:638:9: error: unknown =
type name 'u8'
  638 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:639:9: error: unknown =
type name '__le16'
  639 |         __le16  guaranteed;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:640:9: error: unknown =
type name '__le16'
  640 |         __le16  total;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:641:9: error: unknown =
type name '__le16'
  641 |         __le16  used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_get_update_vsi_completion' is not an =
integer constant
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:749:9: error: unknown =
type name '__le16'
  749 |         __le16  valid_sections;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:642:9: error: unknown =
type name '__le16'
  642 |         __le16  total_unalloced;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:757:9: error: unknown =
type name '__le16'
  757 |         __le16  switch_id; /* 12bit id combined with flags below =
*/
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:643:9: error: unknown =
type name 'u8'
  643 |         u8      reserved2[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:762:9: error: unknown =
type name 'u8'
  762 |         u8      sw_reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:764:9: error: unknown =
type name 'u8'
  764 |         u8      sec_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:646:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  646 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_resource_alloc_element_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:767:9: error: unknown =
type name 'u8'
  767 |         u8      sec_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:769:9: error: unknown =
type name '__le16'
  769 |         __le16  pvid; /* VLANS include priority bits */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:646:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_switch_resource_alloc_element_resp' is not =
an integer constant
  646 | I40E_CHECK_STRUCT_LEN(0x10, =
i40e_aqc_switch_resource_alloc_element_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:770:9: error: unknown =
type name '__le16'
  770 |         __le16  fcoe_pvid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:771:9: error: unknown =
type name 'u8'
  771 |         u8      port_vlan_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:650:9: error: unknown =
type name '__le16'
  650 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:784:9: error: unknown =
type name 'u8'
  784 |         u8      pvlan_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:653:9: error: unknown =
type name '__le16'
  653 |         __le16  valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:786:9: error: unknown =
type name '__le32'
  786 |         __le32  ingress_table; /* bitmap, 3 bits per up */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:659:9: error: unknown =
type name '__le16'
  659 |         __le16  switch_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:787:9: error: unknown =
type name '__le32'
  787 |         __le32  egress_table;   /* same defines as for ingress =
table */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:789:9: error: unknown =
type name '__le16'
  789 |         __le16  cas_pv_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:667:9: error: unknown =
type name '__le16'
  667 |         __le16  first_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:790:9: error: unknown =
type name 'u8'
  790 |         u8      cas_pv_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:668:9: error: unknown =
type name '__le16'
  668 |         __le16  second_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:791:9: error: unknown =
type name 'u8'
  791 |         u8      cas_pv_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:793:9: error: unknown =
type name '__le16'
  793 |         __le16  mapping_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:689:9: error: unknown =
type name 'u8'
  689 |         u8      mode;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:796:9: error: unknown =
type name '__le16'
  796 |         __le16  queue_mapping[16];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:690:9: error: unknown =
type name 'u8'
  690 |         u8      rsvd5[5];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:797:9: error: unknown =
type name '__le16'
  797 |         __le16  tc_mapping[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:801:9: error: unknown =
type name 'u8'
  801 |         u8      queueing_opt_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:804:9: error: unknown =
type name 'u8'
  804 |         u8      queueing_opt_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:806:9: error: unknown =
type name 'u8'
  806 |         u8      up_enable_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:807:9: error: unknown =
type name 'u8'
  807 |         u8      sched_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:809:9: error: unknown =
type name '__le32'
  809 |         __le32  outer_up_table; /* same structure and defines as =
ingress tbl */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_switch_config' is =
not an integer constant
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:693:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  693 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_switch_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:810:9: error: unknown =
type name 'u8'
  810 |         u8      cmd_reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:812:9: error: unknown =
type name '__le16'
  812 |         __le16  qs_handle[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:701:9: error: unknown =
type name '__le32'
  701 |         __le32 reserved1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:814:9: error: unknown =
type name '__le16'
  814 |         __le16  stat_counter_idx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:702:9: error: unknown =
type name '__le32'
  702 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:815:9: error: unknown =
type name '__le16'
  815 |         __le16  sched_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:703:9: error: unknown =
type name '__le32'
  703 |         __le32 reserved2;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:816:9: error: unknown =
type name 'u8'
  816 |         u8      resp_reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:704:9: error: unknown =
type name '__le32'
  704 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:819:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  819 | I40E_CHECK_STRUCT_LEN(128, i40e_aqc_vsi_properties_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:720:9: error: unknown =
type name '__le16'
  720 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:819:28: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_vsi_properties_data' =
is not an integer constant
  819 | I40E_CHECK_STRUCT_LEN(128, i40e_aqc_vsi_properties_data);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:826:9: error: unknown =
type name '__le16'
  826 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:721:9: error: unknown =
type name 'u8'
  721 |         u8      connection_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:827:9: error: unknown =
type name '__le16'
  827 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:723:9: error: unknown =
type name 'u8'
  723 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:828:9: error: unknown =
type name '__le16'
  828 |         __le16  connected_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:829:9: error: unknown =
type name 'u8'
  829 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:724:9: error: unknown =
type name 'u8'
  724 |         u8      vf_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:725:9: error: unknown =
type name 'u8'
  725 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:726:9: error: unknown =
type name '__le16'
  726 |         __le16  vsi_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_update_pv' is not =
an integer constant
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:730:9: error: unknown =
type name '__le32'
  730 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:836:9: error: unknown =
type name '__le16'
  836 |         __le16  pv_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:731:9: error: unknown =
type name '__le32'
  731 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:837:9: error: unknown =
type name 'u8'
  837 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_update_pv_completion' is not an integer =
constant
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:847:9: error: unknown =
type name '__le16'
  847 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_get_update_vsi' is =
not an integer constant
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:734:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  734 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:848:9: error: unknown =
type name '__le16'
  848 |         __le16  default_stag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:737:9: error: unknown =
type name '__le16'
  737 |         __le16 seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:849:9: error: unknown =
type name '__le16'
  849 |         __le16  pv_flags; /* same flags as add_pv */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:850:9: error: unknown =
type name 'u8'
  850 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:738:9: error: unknown =
type name '__le16'
  738 |         __le16 vsi_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:851:9: error: unknown =
type name '__le16'
  851 |         __le16  default_port_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:739:9: error: unknown =
type name '__le16'
  739 |         __le16 vsi_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:740:9: error: unknown =
type name '__le16'
  740 |         __le16 vsi_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:741:9: error: unknown =
type name '__le32'
  741 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_pv_params_completion' is not an integer =
constant
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:742:9: error: unknown =
type name '__le32'
  742 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:858:9: error: unknown =
type name '__le16'
  858 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:859:9: error: unknown =
type name '__le16'
  859 |         __le16  downlink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:860:9: error: unknown =
type name '__le16'
  860 |         __le16  veb_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:865:9: error: unknown =
type name 'u8'
  865 |         u8      enable_tcs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:866:9: error: unknown =
type name 'u8'
  866 |         u8      reserved[9];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_get_update_vsi_completion' is not an =
integer constant
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:745:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  745 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_get_update_vsi_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:749:9: error: unknown =
type name '__le16'
  749 |         __le16  valid_sections;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_veb' is not an =
integer constant
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:757:9: error: unknown =
type name '__le16'
  757 |         __le16  switch_id; /* 12bit id combined with flags below =
*/
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:872:9: error: unknown =
type name 'u8'
  872 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:762:9: error: unknown =
type name 'u8'
  762 |         u8      sw_reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:873:9: error: unknown =
type name '__le16'
  873 |         __le16  switch_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:875:9: error: unknown =
type name '__le16'
  875 |         __le16  veb_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:764:9: error: unknown =
type name 'u8'
  764 |         u8      sec_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:876:9: error: unknown =
type name '__le16'
  876 |         __le16  statistic_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:767:9: error: unknown =
type name 'u8'
  767 |         u8      sec_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:877:9: error: unknown =
type name '__le16'
  877 |         __le16  vebs_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:878:9: error: unknown =
type name '__le16'
  878 |         __le16  vebs_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:769:9: error: unknown =
type name '__le16'
  769 |         __le16  pvid; /* VLANS include priority bits */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:770:9: error: unknown =
type name '__le16'
  770 |         __le16  fcoe_pvid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:771:9: error: unknown =
type name 'u8'
  771 |         u8      port_vlan_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_veb_completion' is =
not an integer constant
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:784:9: error: unknown =
type name 'u8'
  784 |         u8      pvlan_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:887:9: error: unknown =
type name '__le16'
  887 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:888:9: error: unknown =
type name '__le16'
  888 |         __le16  switch_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:786:9: error: unknown =
type name '__le32'
  786 |         __le32  ingress_table; /* bitmap, 3 bits per up */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:889:9: error: unknown =
type name '__le16'
  889 |         __le16  veb_flags; /* only the first/last flags from =
0x0230 is valid */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:787:9: error: unknown =
type name '__le32'
  787 |         __le32  egress_table;   /* same defines as for ingress =
table */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:890:9: error: unknown =
type name '__le16'
  890 |         __le16  statistic_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:891:9: error: unknown =
type name '__le16'
  891 |         __le16  vebs_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:789:9: error: unknown =
type name '__le16'
  789 |         __le16  cas_pv_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:892:9: error: unknown =
type name '__le16'
  892 |         __le16  vebs_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:790:9: error: unknown =
type name 'u8'
  790 |         u8      cas_pv_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:893:9: error: unknown =
type name 'u8'
  893 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:791:9: error: unknown =
type name 'u8'
  791 |         u8      cas_pv_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:793:9: error: unknown =
type name '__le16'
  793 |         __le16  mapping_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_veb_parameters_completion' is not an =
integer constant
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:796:9: error: unknown =
type name '__le16'
  796 |         __le16  queue_mapping[16];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:906:9: error: unknown =
type name '__le16'
  906 |         __le16  num_addresses;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:797:9: error: unknown =
type name '__le16'
  797 |         __le16  tc_mapping[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:907:9: error: unknown =
type name '__le16'
  907 |         __le16  seid[3];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:801:9: error: unknown =
type name 'u8'
  801 |         u8      queueing_opt_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:909:9: error: unknown =
type name '__le32'
  909 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:910:9: error: unknown =
type name '__le32'
  910 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:804:9: error: unknown =
type name 'u8'
  804 |         u8      queueing_opt_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:806:9: error: unknown =
type name 'u8'
  806 |         u8      up_enable_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:807:9: error: unknown =
type name 'u8'
  807 |         u8      sched_reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_macvlan' is not an =
integer constant
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:809:9: error: unknown =
type name '__le32'
  809 |         __le32  outer_up_table; /* same structure and defines as =
ingress tbl */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:917:9: error: unknown =
type name 'u8'
  917 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:918:9: error: unknown =
type name '__le16'
  918 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:810:9: error: unknown =
type name 'u8'
  810 |         u8      cmd_reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:919:9: error: unknown =
type name '__le16'
  919 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:812:9: error: unknown =
type name '__le16'
  812 |         __le16  qs_handle[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:923:9: error: unknown =
type name '__le16'
  923 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:925:9: error: unknown =
type name 'u8'
  925 |         u8      match_method;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:814:9: error: unknown =
type name '__le16'
  814 |         __le16  stat_counter_idx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:927:9: error: unknown =
type name 'u8'
  927 |         u8      reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:815:9: error: unknown =
type name '__le16'
  815 |         __le16  sched_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:931:9: error: unknown =
type name '__le16'
  931 |         __le16 perfect_mac_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:932:9: error: unknown =
type name '__le16'
  932 |         __le16 perfect_mac_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:816:9: error: unknown =
type name 'u8'
  816 |         u8      resp_reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:933:9: error: unknown =
type name '__le16'
  933 |         __le16 unicast_hash_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:934:9: error: unknown =
type name '__le16'
  934 |         __le16 multicast_hash_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:819:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  819 | I40E_CHECK_STRUCT_LEN(128, i40e_aqc_vsi_properties_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:935:9: error: unknown =
type name '__le32'
  935 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:936:9: error: unknown =
type name '__le32'
  936 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:819:28: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_vsi_properties_data' =
is not an integer constant
  819 | I40E_CHECK_STRUCT_LEN(128, i40e_aqc_vsi_properties_data);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:826:9: error: unknown =
type name '__le16'
  826 |         __le16  command_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:827:9: error: unknown =
type name '__le16'
  827 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_macvlan_completion' is not an =
integer constant
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:947:9: error: unknown =
type name 'u8'
  947 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:828:9: error: unknown =
type name '__le16'
  828 |         __le16  connected_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:948:9: error: unknown =
type name '__le16'
  948 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:829:9: error: unknown =
type name 'u8'
  829 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:949:9: error: unknown =
type name 'u8'
  949 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:952:9: error: unknown =
type name 'u8'
  952 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:954:9: error: unknown =
type name 'u8'
  954 |         u8      error_code;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:955:9: error: unknown =
type name 'u8'
  955 |         u8      reply_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:963:9: error: unknown =
type name '__le16'
  963 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:964:9: error: unknown =
type name 'u8'
  964 |         u8      vlan_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_update_pv' is not =
an integer constant
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:832:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  832 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:965:9: error: unknown =
type name 'u8'
  965 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:836:9: error: unknown =
type name '__le16'
  836 |         __le16  pv_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:966:9: error: unknown =
type name 'u8'
  966 |         u8      result;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:967:9: error: unknown =
type name 'u8'
  967 |         u8      reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:837:9: error: unknown =
type name 'u8'
  837 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:971:9: error: unknown =
type name 'u8'
  971 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:972:9: error: unknown =
type name '__le16'
  972 |         __le16  vlans_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:973:9: error: unknown =
type name '__le16'
  973 |         __le16  vlans_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:974:9: error: unknown =
type name '__le32'
  974 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:975:9: error: unknown =
type name '__le32'
  975 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_update_pv_completion' is not an integer =
constant
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:840:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  840 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_update_pv_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:980:9: error: unknown =
type name '__le16'
  980 |         __le16  promiscuous_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:981:9: error: unknown =
type name '__le16'
  981 |         __le16  valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:847:9: error: unknown =
type name '__le16'
  847 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:989:9: error: unknown =
type name '__le16'
  989 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:848:9: error: unknown =
type name '__le16'
  848 |         __le16  default_stag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:990:9: error: unknown =
type name '__le16'
  990 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:992:9: error: unknown =
type name 'u8'
  992 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:849:9: error: unknown =
type name '__le16'
  849 |         __le16  pv_flags; /* same flags as add_pv */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:850:9: error: unknown =
type name 'u8'
  850 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:851:9: error: unknown =
type name '__le16'
  851 |         __le16  default_port_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_set_vsi_promiscuous_modes' is not an =
integer constant
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1001:9: error: unknown =
type name '__le16'
 1001 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1002:9: error: unknown =
type name '__le16'
 1002 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1003:9: error: unknown =
type name '__le16'
 1003 |         __le16  tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1004:9: error: unknown =
type name '__le16'
 1004 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_pv_params_completion' is not an integer =
constant
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:854:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  854 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_pv_params_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1005:9: error: unknown =
type name 'u8'
 1005 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:858:9: error: unknown =
type name '__le16'
  858 |         __le16  uplink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:859:9: error: unknown =
type name '__le16'
  859 |         __le16  downlink_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_tag' is not an =
integer constant
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:860:9: error: unknown =
type name '__le16'
  860 |         __le16  veb_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1011:9: error: unknown =
type name 'u8'
 1011 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:865:9: error: unknown =
type name 'u8'
  865 |         u8      enable_tcs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1012:9: error: unknown =
type name '__le16'
 1012 |         __le16  tags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:866:9: error: unknown =
type name 'u8'
  866 |         u8      reserved[9];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1013:9: error: unknown =
type name '__le16'
 1013 |         __le16  tags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_tag_completion' is not an =
integer constant
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1022:9: error: unknown =
type name '__le16'
 1022 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_veb' is not an =
integer constant
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:869:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  869 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1023:9: error: unknown =
type name '__le16'
 1023 |         __le16  tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1024:9: error: unknown =
type name 'u8'
 1024 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:872:9: error: unknown =
type name 'u8'
  872 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:873:9: error: unknown =
type name '__le16'
  873 |         __le16  switch_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:875:9: error: unknown =
type name '__le16'
  875 |         __le16  veb_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_remove_tag' is not an =
integer constant
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:876:9: error: unknown =
type name '__le16'
  876 |         __le16  statistic_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1034:9: error: unknown =
type name '__le16'
 1034 |         __le16  pv_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1035:9: error: unknown =
type name '__le16'
 1035 |         __le16  etag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:877:9: error: unknown =
type name '__le16'
  877 |         __le16  vebs_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1036:9: error: unknown =
type name 'u8'
 1036 |         u8      num_unicast_etags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:878:9: error: unknown =
type name '__le16'
  878 |         __le16  vebs_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1037:9: error: unknown =
type name 'u8'
 1037 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1038:9: error: unknown =
type name '__le32'
 1038 |         __le32  addr_high;          /* address of array of =
2-byte s-tags */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1039:9: error: unknown =
type name '__le32'
 1039 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_veb_completion' is =
not an integer constant
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:881:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  881 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_veb_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_remove_mcast_etag' =
is not an integer constant
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1045:9: error: unknown =
type name 'u8'
 1045 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1046:9: error: unknown =
type name '__le16'
 1046 |         __le16  mcast_etags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:887:9: error: unknown =
type name '__le16'
  887 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1047:9: error: unknown =
type name '__le16'
 1047 |         __le16  mcast_etags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:888:9: error: unknown =
type name '__le16'
  888 |         __le16  switch_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1048:9: error: unknown =
type name '__le32'
 1048 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:889:9: error: unknown =
type name '__le16'
  889 |         __le16  veb_flags; /* only the first/last flags from =
0x0230 is valid */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1049:9: error: unknown =
type name '__le32'
 1049 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:890:9: error: unknown =
type name '__le16'
  890 |         __le16  statistic_index;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:891:9: error: unknown =
type name '__le16'
  891 |         __le16  vebs_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:892:9: error: unknown =
type name '__le16'
  892 |         __le16  vebs_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:893:9: error: unknown =
type name 'u8'
  893 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_mcast_etag_completion' is not an =
integer constant
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1057:9: error: unknown =
type name '__le16'
 1057 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1058:9: error: unknown =
type name '__le16'
 1058 |         __le16  old_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_veb_parameters_completion' is not an =
integer constant
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:896:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  896 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_veb_parameters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1059:9: error: unknown =
type name '__le16'
 1059 |         __le16  new_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:906:9: error: unknown =
type name '__le16'
  906 |         __le16  num_addresses;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1060:9: error: unknown =
type name 'u8'
 1060 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:907:9: error: unknown =
type name '__le16'
  907 |         __le16  seid[3];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:909:9: error: unknown =
type name '__le32'
  909 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:910:9: error: unknown =
type name '__le32'
  910 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_update_tag' is not an =
integer constant
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1066:9: error: unknown =
type name 'u8'
 1066 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_macvlan' is not an =
integer constant
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:913:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  913 | I40E_CHECK_CMD_LENGTH(i40e_aqc_macvlan);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1067:9: error: unknown =
type name '__le16'
 1067 |         __le16  tags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:917:9: error: unknown =
type name 'u8'
  917 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1068:9: error: unknown =
type name '__le16'
 1068 |         __le16  tags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:918:9: error: unknown =
type name '__le16'
  918 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:919:9: error: unknown =
type name '__le16'
  919 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:923:9: error: unknown =
type name '__le16'
  923 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:925:9: error: unknown =
type name 'u8'
  925 |         u8      match_method;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_update_tag_completion' =
is not an integer constant
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:927:9: error: unknown =
type name 'u8'
  927 |         u8      reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1079:9: error: unknown =
type name 'u8'
 1079 |         u8      mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:931:9: error: unknown =
type name '__le16'
  931 |         __le16 perfect_mac_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1080:9: error: unknown =
type name '__le16'
 1080 |         __le16  etype;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:932:9: error: unknown =
type name '__le16'
  932 |         __le16 perfect_mac_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1081:9: error: unknown =
type name '__le16'
 1081 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:933:9: error: unknown =
type name '__le16'
  933 |         __le16 unicast_hash_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1086:9: error: unknown =
type name '__le16'
 1086 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:934:9: error: unknown =
type name '__le16'
  934 |         __le16 multicast_hash_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1087:9: error: unknown =
type name '__le16'
 1087 |         __le16  queue;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:935:9: error: unknown =
type name '__le32'
  935 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1088:9: error: unknown =
type name 'u8'
 1088 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:936:9: error: unknown =
type name '__le32'
  936 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_control_packet_filter' is not an =
integer constant
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_macvlan_completion' is not an =
integer constant
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:939:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  939 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_macvlan_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1094:9: error: unknown =
type name '__le16'
 1094 |         __le16  mac_etype_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:947:9: error: unknown =
type name 'u8'
  947 |         u8      mac_addr[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1095:9: error: unknown =
type name '__le16'
 1095 |         __le16  etype_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:948:9: error: unknown =
type name '__le16'
  948 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1096:9: error: unknown =
type name '__le16'
 1096 |         __le16  mac_etype_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:949:9: error: unknown =
type name 'u8'
  949 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1097:9: error: unknown =
type name '__le16'
 1097 |         __le16  etype_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:952:9: error: unknown =
type name 'u8'
  952 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1098:9: error: unknown =
type name 'u8'
 1098 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:954:9: error: unknown =
type name 'u8'
  954 |         u8      error_code;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:955:9: error: unknown =
type name 'u8'
  955 |         u8      reply_reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:963:9: error: unknown =
type name '__le16'
  963 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:964:9: error: unknown =
type name 'u8'
  964 |         u8      vlan_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:965:9: error: unknown =
type name 'u8'
  965 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_control_packet_filter_completion' =
is not an integer constant
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      |                       =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:966:9: error: unknown =
type name 'u8'
  966 |         u8      result;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1109:9: error: unknown =
type name 'u8'
 1109 |         u8      num_filters;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:967:9: error: unknown =
type name 'u8'
  967 |         u8      reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1110:9: error: unknown =
type name 'u8'
 1110 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:971:9: error: unknown =
type name 'u8'
  971 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1111:9: error: unknown =
type name '__le16'
 1111 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:972:9: error: unknown =
type name '__le16'
  972 |         __le16  vlans_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1112:9: error: unknown =
type name 'u8'
 1112 |         u8      big_buffer_flag;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:973:9: error: unknown =
type name '__le16'
  973 |         __le16  vlans_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:974:9: error: unknown =
type name '__le32'
  974 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1114:9: error: unknown =
type name 'u8'
 1114 |         u8      reserved2[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:975:9: error: unknown =
type name '__le32'
  975 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1115:9: error: unknown =
type name '__le32'
 1115 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:980:9: error: unknown =
type name '__le16'
  980 |         __le16  promiscuous_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1116:9: error: unknown =
type name '__le32'
 1116 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:981:9: error: unknown =
type name '__le16'
  981 |         __le16  valid_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:989:9: error: unknown =
type name '__le16'
  989 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:990:9: error: unknown =
type name '__le16'
  990 |         __le16  vlan_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:992:9: error: unknown =
type name 'u8'
  992 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_cloud_filters' is not an integer =
constant
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1122:9: error: unknown =
type name 'u8'
 1122 |         u8      outer_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1123:9: error: unknown =
type name 'u8'
 1123 |         u8      inner_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_set_vsi_promiscuous_modes' is not an =
integer constant
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:995:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
  995 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_vsi_promiscuous_modes);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1124:9: error: unknown =
type name '__le16'
 1124 |         __le16  inner_vlan;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1001:9: error: unknown =
type name '__le16'
 1001 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1127:25: error: =
unknown type name 'u8'
 1127 |                         u8 reserved[12];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1002:9: error: unknown =
type name '__le16'
 1002 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1128:25: error: =
unknown type name 'u8'
 1128 |                         u8 data[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1003:9: error: unknown =
type name '__le16'
 1003 |         __le16  tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1004:9: error: unknown =
type name '__le16'
 1004 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1131:25: error: =
unknown type name 'u8'
 1131 |                         u8 data[16];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1005:9: error: unknown =
type name 'u8'
 1005 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1134:25: error: =
unknown type name '__le16'
 1134 |                         __le16 data[8];
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1137:9: error: unknown =
type name '__le16'
 1137 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1167:9: error: unknown =
type name '__le32'
 1167 |         __le32  tenant_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1168:9: error: unknown =
type name 'u8'
 1168 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_tag' is not an =
integer constant
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      |                       ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1008:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1008 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1169:9: error: unknown =
type name '__le16'
 1169 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1011:9: error: unknown =
type name 'u8'
 1011 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1170:9: error: unknown =
type name 'u8'
 1170 |         u8      reserved2[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1012:9: error: unknown =
type name '__le16'
 1012 |         __le16  tags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1172:9: error: unknown =
type name 'u8'
 1172 |         u8      allocation_result;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1013:9: error: unknown =
type name '__le16'
 1013 |         __le16  tags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1173:9: error: unknown =
type name 'u8'
 1173 |         u8      response_reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1176:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1176 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_cloud_filters_element_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_tag_completion' is not an =
integer constant
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1016:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1016 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1176:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an =
integer constant
 1176 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_cloud_filters_element_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1022:9: error: unknown =
type name '__le16'
 1022 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1183:9: error: unknown =
type name 'u16'
 1183 |         u16     general_fields[32];
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1023:9: error: unknown =
type name '__le16'
 1023 |         __le16  tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1187:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1187 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1024:9: error: unknown =
type name 'u8'
 1024 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1187:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer =
constant
 1187 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1190:9: error: unknown =
type name '__le16'
 1190 |         __le16 perfect_ovlan_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_remove_tag' is not an =
integer constant
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1027:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1027 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1191:9: error: unknown =
type name '__le16'
 1191 |         __le16 perfect_ovlan_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1034:9: error: unknown =
type name '__le16'
 1034 |         __le16  pv_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1192:9: error: unknown =
type name '__le16'
 1192 |         __le16 vlan_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1035:9: error: unknown =
type name '__le16'
 1035 |         __le16  etag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1193:9: error: unknown =
type name '__le16'
 1193 |         __le16 vlan_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1036:9: error: unknown =
type name 'u8'
 1036 |         u8      num_unicast_etags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1194:9: error: unknown =
type name '__le32'
 1194 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1037:9: error: unknown =
type name 'u8'
 1037 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1038:9: error: unknown =
type name '__le32'
 1038 |         __le32  addr_high;          /* address of array of =
2-byte s-tags */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1195:9: error: unknown =
type name '__le32'
 1195 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1039:9: error: unknown =
type name '__le32'
 1039 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_remove_cloud_filters_completion' is not an =
integer constant
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_remove_mcast_etag' =
is not an integer constant
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1042:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1042 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1205:9: error: unknown =
type name 'u8'
 1205 |         u8 filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1045:9: error: unknown =
type name 'u8'
 1045 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1206:9: error: unknown =
type name 'u8'
 1206 |         u8 input[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1046:9: error: unknown =
type name '__le16'
 1046 |         __le16  mcast_etags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1209:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1209 | I40E_CHECK_STRUCT_LEN(4, i40e_filter_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1047:9: error: unknown =
type name '__le16'
 1047 |         __le16  mcast_etags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1048:9: error: unknown =
type name '__le32'
 1048 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1209:26: error: =
enumerator value for 'i40e_static_assert_i40e_filter_data' is not an =
integer constant
 1209 | I40E_CHECK_STRUCT_LEN(4, i40e_filter_data);
      |                          ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1049:9: error: unknown =
type name '__le32'
 1049 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1212:9: error: unknown =
type name 'u8'
 1212 |         u8      valid_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1213:9: error: unknown =
type name 'u8'
 1213 |         u8      old_filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1214:9: error: unknown =
type name 'u8'
 1214 |         u8      new_filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_mcast_etag_completion' is not an =
integer constant
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1053:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1053 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_mcast_etag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1215:9: error: unknown =
type name 'u8'
 1215 |         u8      tr_bit;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1057:9: error: unknown =
type name '__le16'
 1057 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1058:9: error: unknown =
type name '__le16'
 1058 |         __le16  old_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1216:9: error: unknown =
type name 'u8'
 1216 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1059:9: error: unknown =
type name '__le16'
 1059 |         __le16  new_tag;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1217:9: error: unknown =
type name '__le32'
 1217 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1060:9: error: unknown =
type name 'u8'
 1060 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1218:9: error: unknown =
type name '__le32'
 1218 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_update_tag' is not an =
integer constant
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1063:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1063 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_replace_cloud_filters_cmd' is not an =
integer constant
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1066:9: error: unknown =
type name 'u8'
 1066 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1224:9: error: unknown =
type name 'u8'
 1224 |         u8      data[32];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1067:9: error: unknown =
type name '__le16'
 1067 |         __le16  tags_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1068:9: error: unknown =
type name '__le16'
 1068 |         __le16  tags_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1228:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1228 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_replace_cloud_filters_cmd_buf);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1228:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_replace_cloud_filters_cmd_buf' is not an =
integer constant
 1228 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_replace_cloud_filters_cmd_buf);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_update_tag_completion' =
is not an integer constant
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_update_tag_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1236:9: error: unknown =
type name '__le16'
 1236 |         __le16 seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1079:9: error: unknown =
type name 'u8'
 1079 |         u8      mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1237:9: error: unknown =
type name '__le16'
 1237 |         __le16 rule_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1080:9: error: unknown =
type name '__le16'
 1080 |         __le16  etype;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1081:9: error: unknown =
type name '__le16'
 1081 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1244:9: error: unknown =
type name '__le16'
 1244 |         __le16 num_entries;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1245:9: error: unknown =
type name '__le16'
 1245 |         __le16 destination;  /* VSI for add, rule id for delete =
*/
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1086:9: error: unknown =
type name '__le16'
 1086 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1087:9: error: unknown =
type name '__le16'
 1087 |         __le16  queue;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1246:9: error: unknown =
type name '__le32'
 1246 |         __le32 addr_high;    /* address of array of 2-byte VSI =
or VLAN ids */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1088:9: error: unknown =
type name 'u8'
 1088 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1247:9: error: unknown =
type name '__le32'
 1247 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_control_packet_filter' is not an =
integer constant
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1091:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1091 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_delete_mirror_rule' is not an integer =
constant
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1094:9: error: unknown =
type name '__le16'
 1094 |         __le16  mac_etype_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1095:9: error: unknown =
type name '__le16'
 1095 |         __le16  etype_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1253:9: error: unknown =
type name 'u8'
 1253 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1096:9: error: unknown =
type name '__le16'
 1096 |         __le16  mac_etype_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1254:9: error: unknown =
type name '__le16'
 1254 |         __le16  rule_id;  /* only used on add */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1097:9: error: unknown =
type name '__le16'
 1097 |         __le16  etype_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1098:9: error: unknown =
type name 'u8'
 1098 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1255:9: error: unknown =
type name '__le16'
 1255 |         __le16  mirror_rules_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1256:9: error: unknown =
type name '__le16'
 1256 |         __le16  mirror_rules_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1257:9: error: unknown =
type name '__le32'
 1257 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1258:9: error: unknown =
type name '__le32'
 1258 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_control_packet_filter_completion' =
is not an integer constant
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      |                       =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1101:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1101 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_control_packet_filter_completion=
);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1109:9: error: unknown =
type name 'u8'
 1109 |         u8      num_filters;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1110:9: error: unknown =
type name 'u8'
 1110 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1111:9: error: unknown =
type name '__le16'
 1111 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1112:9: error: unknown =
type name 'u8'
 1112 |         u8      big_buffer_flag;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_delete_mirror_rule_completion' is not =
an integer constant
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1114:9: error: unknown =
type name 'u8'
 1114 |         u8      reserved2[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1265:9: error: unknown =
type name 'u8'
 1265 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1115:9: error: unknown =
type name '__le32'
 1115 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1266:9: error: unknown =
type name 'u8'
 1266 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1116:9: error: unknown =
type name '__le32'
 1116 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1267:9: error: unknown =
type name '__le32'
 1267 |         __le32  profile_track_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1268:9: error: unknown =
type name '__le32'
 1268 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1269:9: error: unknown =
type name '__le32'
 1269 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_remove_cloud_filters' is not an integer =
constant
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1119:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1119 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_remove_cloud_filters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1122:9: error: unknown =
type name 'u8'
 1122 |         u8      outer_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1123:9: error: unknown =
type name 'u8'
 1123 |         u8      inner_mac[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1124:9: error: unknown =
type name '__le16'
 1124 |         __le16  inner_vlan;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_write_personalization_profile' is not an =
integer constant
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1127:25: error: =
unknown type name 'u8'
 1127 |                         u8 reserved[12];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1275:9: error: unknown =
type name '__le32'
 1275 |         __le32 error_offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1128:25: error: =
unknown type name 'u8'
 1128 |                         u8 data[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1276:9: error: unknown =
type name '__le32'
 1276 |         __le32 error_info;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1131:25: error: =
unknown type name 'u8'
 1131 |                         u8 data[16];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1277:9: error: unknown =
type name '__le32'
 1277 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1134:25: error: =
unknown type name '__le16'
 1134 |                         __le16 data[8];
      |                         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1137:9: error: unknown =
type name '__le16'
 1137 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1278:9: error: unknown =
type name '__le32'
 1278 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1167:9: error: unknown =
type name '__le32'
 1167 |         __le32  tenant_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1282:9: error: unknown =
type name 'u8'
 1282 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1168:9: error: unknown =
type name 'u8'
 1168 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1283:9: error: unknown =
type name 'u8'
 1283 |         u8      rsv[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1169:9: error: unknown =
type name '__le16'
 1169 |         __le16  queue_number;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1284:9: error: unknown =
type name '__le32'
 1284 |         __le32  reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1170:9: error: unknown =
type name 'u8'
 1170 |         u8      reserved2[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1172:9: error: unknown =
type name 'u8'
 1172 |         u8      allocation_result;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1285:9: error: unknown =
type name '__le32'
 1285 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1173:9: error: unknown =
type name 'u8'
 1173 |         u8      response_reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1286:9: error: unknown =
type name '__le32'
 1286 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1176:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1176 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_cloud_filters_element_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1176:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_cloud_filters_element_data' is not an =
integer constant
 1176 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_cloud_filters_element_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1183:9: error: unknown =
type name 'u16'
 1183 |         u16     general_fields[32];
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_applied_profiles' =
is not an integer constant
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1187:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1187 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1297:9: error: unknown =
type name 'u8'
 1297 |         u8      tc_bitmap;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1187:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_cloud_filters_element_bb' is not an integer =
constant
 1187 | I40E_CHECK_STRUCT_LEN(0x80, i40e_aqc_cloud_filters_element_bb);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1298:9: error: unknown =
type name 'u8'
 1298 |         u8      command_flags; /* unused on response */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1190:9: error: unknown =
type name '__le16'
 1190 |         __le16 perfect_ovlan_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1299:9: error: unknown =
type name 'u8'
 1299 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1191:9: error: unknown =
type name '__le16'
 1191 |         __le16 perfect_ovlan_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1192:9: error: unknown =
type name '__le16'
 1192 |         __le16 vlan_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1193:9: error: unknown =
type name '__le16'
 1193 |         __le16 vlan_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1194:9: error: unknown =
type name '__le32'
 1194 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_pfc_ignore' is not an =
integer constant
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1195:9: error: unknown =
type name '__le32'
 1195 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1314:9: error: unknown =
type name '__le16'
 1314 |         __le16  vsi_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1315:9: error: unknown =
type name 'u8'
 1315 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1316:9: error: unknown =
type name '__le32'
 1316 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_remove_cloud_filters_completion' is not an =
integer constant
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1198:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1198 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_cloud_filters_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1317:9: error: unknown =
type name '__le32'
 1317 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1205:9: error: unknown =
type name 'u8'
 1205 |         u8 filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1206:9: error: unknown =
type name 'u8'
 1206 |         u8 input[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1209:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1209 | I40E_CHECK_STRUCT_LEN(4, i40e_filter_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_tx_sched_ind' is not =
an integer constant
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1209:26: error: =
enumerator value for 'i40e_static_assert_i40e_filter_data' is not an =
integer constant
 1209 | I40E_CHECK_STRUCT_LEN(4, i40e_filter_data);
      |                          ^~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1324:9: error: unknown =
type name '__le16'
 1324 |         __le16 qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1212:9: error: unknown =
type name 'u8'
 1212 |         u8      valid_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1329:9: error: unknown =
type name '__le16'
 1329 |         __le16  vsi_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1213:9: error: unknown =
type name 'u8'
 1213 |         u8      old_filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1214:9: error: unknown =
type name 'u8'
 1214 |         u8      new_filter_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1330:9: error: unknown =
type name 'u8'
 1330 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1215:9: error: unknown =
type name 'u8'
 1215 |         u8      tr_bit;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1331:9: error: unknown =
type name '__le16'
 1331 |         __le16  credit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1216:9: error: unknown =
type name 'u8'
 1216 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1332:9: error: unknown =
type name 'u8'
 1332 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1217:9: error: unknown =
type name '__le32'
 1217 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1333:9: error: unknown =
type name 'u8'
 1333 |         u8      max_credit; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1218:9: error: unknown =
type name '__le32'
 1218 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1334:9: error: unknown =
type name 'u8'
 1334 |         u8      reserved2[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_replace_cloud_filters_cmd' is not an =
integer constant
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1221:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1221 | I40E_CHECK_CMD_LENGTH(i40e_aqc_replace_cloud_filters_cmd);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_bw_limit' is not an integer =
constant
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1224:9: error: unknown =
type name 'u8'
 1224 |         u8      data[32];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1343:9: error: unknown =
type name 'u8'
 1343 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1228:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1228 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_replace_cloud_filters_cmd_buf);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1344:9: error: unknown =
type name 'u8'
 1344 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1228:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_replace_cloud_filters_cmd_buf' is not an =
integer constant
 1228 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_replace_cloud_filters_cmd_buf);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1345:9: error: unknown =
type name '__le16'
 1345 |         __le16  tc_bw_credits[8]; /* FW writesback QS handles =
here */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1236:9: error: unknown =
type name '__le16'
 1236 |         __le16 seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1348:9: error: unknown =
type name '__le16'
 1348 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1237:9: error: unknown =
type name '__le16'
 1237 |         __le16 rule_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1349:9: error: unknown =
type name 'u8'
 1349 |         u8      reserved1[28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1244:9: error: unknown =
type name '__le16'
 1244 |         __le16 num_entries;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1352:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1352 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_configure_vsi_ets_sla_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1245:9: error: unknown =
type name '__le16'
 1245 |         __le16 destination;  /* VSI for add, rule id for delete =
*/
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1246:9: error: unknown =
type name '__le32'
 1246 |         __le32 addr_high;    /* address of array of 2-byte VSI =
or VLAN ids */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1352:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_ets_sla_bw_data' is not an =
integer constant
 1352 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_configure_vsi_ets_sla_bw_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1247:9: error: unknown =
type name '__le32'
 1247 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1358:9: error: unknown =
type name 'u8'
 1358 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1359:9: error: unknown =
type name 'u8'
 1359 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1360:9: error: unknown =
type name 'u8'
 1360 |         u8      tc_bw_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_delete_mirror_rule' is not an integer =
constant
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1250:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1250 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1361:9: error: unknown =
type name 'u8'
 1361 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1253:9: error: unknown =
type name 'u8'
 1253 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1362:9: error: unknown =
type name '__le16'
 1362 |         __le16  qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1254:9: error: unknown =
type name '__le16'
 1254 |         __le16  rule_id;  /* only used on add */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1365:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1365 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_configure_vsi_tc_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1255:9: error: unknown =
type name '__le16'
 1255 |         __le16  mirror_rules_used;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1256:9: error: unknown =
type name '__le16'
 1256 |         __le16  mirror_rules_free;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1365:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_tc_bw_data' is not an integer =
constant
 1365 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_configure_vsi_tc_bw_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1257:9: error: unknown =
type name '__le32'
 1257 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1369:9: error: unknown =
type name 'u8'
 1369 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1258:9: error: unknown =
type name '__le32'
 1258 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1370:9: error: unknown =
type name 'u8'
 1370 |         u8      tc_suspended_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1371:9: error: unknown =
type name 'u8'
 1371 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1372:9: error: unknown =
type name '__le16'
 1372 |         __le16  qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_delete_mirror_rule_completion' is not =
an integer constant
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1261:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1261 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_add_delete_mirror_rule_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1373:9: error: unknown =
type name 'u8'
 1373 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1265:9: error: unknown =
type name 'u8'
 1265 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1374:9: error: unknown =
type name '__le16'
 1374 |         __le16  port_bw_limit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1266:9: error: unknown =
type name 'u8'
 1266 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1375:9: error: unknown =
type name 'u8'
 1375 |         u8      reserved2[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1267:9: error: unknown =
type name '__le32'
 1267 |         __le32  profile_track_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1376:9: error: unknown =
type name 'u8'
 1376 |         u8      max_bw; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1268:9: error: unknown =
type name '__le32'
 1268 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1377:9: error: unknown =
type name 'u8'
 1377 |         u8      reserved3[23];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1269:9: error: unknown =
type name '__le32'
 1269 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1380:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1380 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_query_vsi_bw_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1380:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_vsi_bw_config_resp' is not an integer =
constant
 1380 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_query_vsi_bw_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_write_personalization_profile' is not an =
integer constant
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1272:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1272 | I40E_CHECK_CMD_LENGTH(i40e_aqc_write_personalization_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1384:9: error: unknown =
type name 'u8'
 1384 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1275:9: error: unknown =
type name '__le32'
 1275 |         __le32 error_offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1385:9: error: unknown =
type name 'u8'
 1385 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1276:9: error: unknown =
type name '__le32'
 1276 |         __le32 error_info;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1386:9: error: unknown =
type name 'u8'
 1386 |         u8      share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1277:9: error: unknown =
type name '__le32'
 1277 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1387:9: error: unknown =
type name '__le16'
 1387 |         __le16  credits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1278:9: error: unknown =
type name '__le32'
 1278 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1390:9: error: unknown =
type name '__le16'
 1390 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1282:9: error: unknown =
type name 'u8'
 1282 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1283:9: error: unknown =
type name 'u8'
 1283 |         u8      rsv[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1393:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1393 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_vsi_ets_sla_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1284:9: error: unknown =
type name '__le32'
 1284 |         __le32  reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1393:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_vsi_ets_sla_config_resp' is not an =
integer constant
 1393 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_vsi_ets_sla_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1285:9: error: unknown =
type name '__le32'
 1285 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1397:9: error: unknown =
type name '__le16'
 1397 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1286:9: error: unknown =
type name '__le32'
 1286 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1398:9: error: unknown =
type name 'u8'
 1398 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1399:9: error: unknown =
type name '__le16'
 1399 |         __le16  credit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1400:9: error: unknown =
type name 'u8'
 1400 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_applied_profiles' =
is not an integer constant
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1289:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1289 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_applied_profiles);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1401:9: error: unknown =
type name 'u8'
 1401 |         u8      max_bw; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1297:9: error: unknown =
type name 'u8'
 1297 |         u8      tc_bitmap;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1298:9: error: unknown =
type name 'u8'
 1298 |         u8      command_flags; /* unused on response */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1402:9: error: unknown =
type name 'u8'
 1402 |         u8      reserved2[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1299:9: error: unknown =
type name 'u8'
 1299 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_bw_limit' is not =
an integer constant
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1412:9: error: unknown =
type name 'u8'
 1412 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_pfc_ignore' is not an =
integer constant
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1302:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1302 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pfc_ignore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1413:9: error: unknown =
type name 'u8'
 1413 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1314:9: error: unknown =
type name '__le16'
 1314 |         __le16  vsi_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1315:9: error: unknown =
type name 'u8'
 1315 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1414:9: error: unknown =
type name 'u8'
 1414 |         u8      seepage;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1316:9: error: unknown =
type name '__le32'
 1316 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1415:9: error: unknown =
type name 'u8'
 1415 |         u8      tc_strict_priority_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1317:9: error: unknown =
type name '__le32'
 1317 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1416:9: error: unknown =
type name 'u8'
 1416 |         u8      reserved1[17];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1417:9: error: unknown =
type name 'u8'
 1417 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1418:9: error: unknown =
type name 'u8'
 1418 |         u8      reserved2[96];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_tx_sched_ind' is not =
an integer constant
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1320:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1320 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tx_sched_ind);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1421:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1421 | I40E_CHECK_STRUCT_LEN(0x80, =
i40e_aqc_configure_switching_comp_ets_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1324:9: error: unknown =
type name '__le16'
 1324 |         __le16 qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1421:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_ets_data' is not =
an integer constant
 1421 | I40E_CHECK_STRUCT_LEN(0x80, =
i40e_aqc_configure_switching_comp_ets_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1329:9: error: unknown =
type name '__le16'
 1329 |         __le16  vsi_seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1425:9: error: unknown =
type name 'u8'
 1425 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1330:9: error: unknown =
type name 'u8'
 1330 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1331:9: error: unknown =
type name '__le16'
 1331 |         __le16  credit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1426:9: error: unknown =
type name 'u8'
 1426 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1332:9: error: unknown =
type name 'u8'
 1332 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1427:9: error: unknown =
type name '__le16'
 1427 |         __le16  tc_bw_credit[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1333:9: error: unknown =
type name 'u8'
 1333 |         u8      max_credit; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1430:9: error: unknown =
type name '__le16'
 1430 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1334:9: error: unknown =
type name 'u8'
 1334 |         u8      reserved2[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1431:9: error: unknown =
type name 'u8'
 1431 |         u8      reserved1[28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1434:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1434 | I40E_CHECK_STRUCT_LEN(0x40,
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1435:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_ets_bw_limit_data' =
is not an integer constant
 1435 |                       =
i40e_aqc_configure_switching_comp_ets_bw_limit_data);
      |                       =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_bw_limit' is not an integer =
constant
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1337:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1337 | I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_vsi_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1441:9: error: unknown =
type name 'u8'
 1441 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1343:9: error: unknown =
type name 'u8'
 1343 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1442:9: error: unknown =
type name 'u8'
 1442 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1344:9: error: unknown =
type name 'u8'
 1344 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1443:9: error: unknown =
type name 'u8'
 1443 |         u8      absolute_credits; /* bool */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1345:9: error: unknown =
type name '__le16'
 1345 |         __le16  tc_bw_credits[8]; /* FW writesback QS handles =
here */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1444:9: error: unknown =
type name 'u8'
 1444 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1348:9: error: unknown =
type name '__le16'
 1348 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1349:9: error: unknown =
type name 'u8'
 1349 |         u8      reserved1[28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1445:9: error: unknown =
type name 'u8'
 1445 |         u8      reserved1[20];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1352:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1352 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_configure_vsi_ets_sla_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1448:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1448 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_configure_switching_comp_bw_config_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1352:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_ets_sla_bw_data' is not an =
integer constant
 1352 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_configure_vsi_ets_sla_bw_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1448:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_bw_config_data' is =
not an integer constant
 1448 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_configure_switching_comp_bw_config_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1358:9: error: unknown =
type name 'u8'
 1358 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1452:9: error: unknown =
type name 'u8'
 1452 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1359:9: error: unknown =
type name 'u8'
 1359 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1453:9: error: unknown =
type name 'u8'
 1453 |         u8      reserved[35];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1360:9: error: unknown =
type name 'u8'
 1360 |         u8      tc_bw_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1454:9: error: unknown =
type name '__le16'
 1454 |         __le16  port_bw_limit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1361:9: error: unknown =
type name 'u8'
 1361 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1455:9: error: unknown =
type name 'u8'
 1455 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1362:9: error: unknown =
type name '__le16'
 1362 |         __le16  qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1456:9: error: unknown =
type name 'u8'
 1456 |         u8      tc_bw_max; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1365:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1365 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_configure_vsi_tc_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1457:9: error: unknown =
type name 'u8'
 1457 |         u8      reserved2[23];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1365:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_vsi_tc_bw_data' is not an integer =
constant
 1365 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_configure_vsi_tc_bw_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1460:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1460 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_query_switching_comp_ets_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1369:9: error: unknown =
type name 'u8'
 1369 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1460:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_switching_comp_ets_config_resp' is =
not an integer constant
 1460 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_query_switching_comp_ets_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1370:9: error: unknown =
type name 'u8'
 1370 |         u8      tc_suspended_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1464:9: error: unknown =
type name 'u8'
 1464 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1371:9: error: unknown =
type name 'u8'
 1371 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1465:9: error: unknown =
type name 'u8'
 1465 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1372:9: error: unknown =
type name '__le16'
 1372 |         __le16  qs_handles[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1466:9: error: unknown =
type name 'u8'
 1466 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1373:9: error: unknown =
type name 'u8'
 1373 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1467:9: error: unknown =
type name 'u8'
 1467 |         u8      tc_strict_priority_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1374:9: error: unknown =
type name '__le16'
 1374 |         __le16  port_bw_limit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1375:9: error: unknown =
type name 'u8'
 1375 |         u8      reserved2[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1468:9: error: unknown =
type name 'u8'
 1468 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1376:9: error: unknown =
type name 'u8'
 1376 |         u8      max_bw; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1469:9: error: unknown =
type name 'u8'
 1469 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1377:9: error: unknown =
type name 'u8'
 1377 |         u8      reserved3[23];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1470:9: error: unknown =
type name '__le16'
 1470 |         __le16  tc_bw_limits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1473:9: error: unknown =
type name '__le16'
 1473 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1380:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1380 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_query_vsi_bw_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1474:9: error: unknown =
type name 'u8'
 1474 |         u8      reserved3[32];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1380:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_vsi_bw_config_resp' is not an integer =
constant
 1380 | I40E_CHECK_STRUCT_LEN(0x40, i40e_aqc_query_vsi_bw_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1477:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1477 | I40E_CHECK_STRUCT_LEN(0x44, =
i40e_aqc_query_port_ets_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1384:9: error: unknown =
type name 'u8'
 1384 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1477:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_port_ets_config_resp' is not an =
integer constant
 1477 | I40E_CHECK_STRUCT_LEN(0x44, =
i40e_aqc_query_port_ets_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1385:9: error: unknown =
type name 'u8'
 1385 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1386:9: error: unknown =
type name 'u8'
 1386 |         u8      share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1483:9: error: unknown =
type name 'u8'
 1483 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1387:9: error: unknown =
type name '__le16'
 1387 |         __le16  credits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1484:9: error: unknown =
type name 'u8'
 1484 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1390:9: error: unknown =
type name '__le16'
 1390 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1485:9: error: unknown =
type name 'u8'
 1485 |         u8      absolute_credits_enable; /* bool */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1393:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1393 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_vsi_ets_sla_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1486:9: error: unknown =
type name 'u8'
 1486 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1487:9: error: unknown =
type name '__le16'
 1487 |         __le16  tc_bw_limits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1393:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_vsi_ets_sla_config_resp' is not an =
integer constant
 1393 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_vsi_ets_sla_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1490:9: error: unknown =
type name '__le16'
 1490 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1397:9: error: unknown =
type name '__le16'
 1397 |         __le16  seid;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1493:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1493 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_switching_comp_bw_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1398:9: error: unknown =
type name 'u8'
 1398 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1399:9: error: unknown =
type name '__le16'
 1399 |         __le16  credit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1493:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_switching_comp_bw_config_resp' is not =
an integer constant
 1493 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_switching_comp_bw_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1400:9: error: unknown =
type name 'u8'
 1400 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1503:9: error: unknown =
type name '__le16'
 1503 |         __le16  pf_valid_bits;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1401:9: error: unknown =
type name 'u8'
 1401 |         u8      max_bw; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1504:9: error: unknown =
type name 'u8'
 1504 |         u8      min_bw[16];      /* guaranteed bandwidth */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1402:9: error: unknown =
type name 'u8'
 1402 |         u8      reserved2[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1505:9: error: unknown =
type name 'u8'
 1505 |         u8      max_bw[16];      /* bandwidth limit */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1508:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1508 | I40E_CHECK_STRUCT_LEN(0x22, =
i40e_aqc_configure_partition_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_bw_limit' is not =
an integer constant
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1405:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1405 | =
I40E_CHECK_CMD_LENGTH(i40e_aqc_configure_switching_comp_bw_limit);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1508:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an =
integer constant
 1508 | I40E_CHECK_STRUCT_LEN(0x22, =
i40e_aqc_configure_partition_bw_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1412:9: error: unknown =
type name 'u8'
 1412 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1514:9: error: unknown =
type name 'u8'
 1514 |         u8      pm_profile;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1413:9: error: unknown =
type name 'u8'
 1413 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1515:9: error: unknown =
type name 'u8'
 1515 |         u8      pe_vf_enabled;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1414:9: error: unknown =
type name 'u8'
 1414 |         u8      seepage;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1516:9: error: unknown =
type name 'u8'
 1516 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1415:9: error: unknown =
type name 'u8'
 1415 |         u8      tc_strict_priority_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1416:9: error: unknown =
type name 'u8'
 1416 |         u8      reserved1[17];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1417:9: error: unknown =
type name 'u8'
 1417 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1418:9: error: unknown =
type name 'u8'
 1418 |         u8      reserved2[96];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aq_get_set_hmc_resource_profile' is not an =
integer constant
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1421:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1421 | I40E_CHECK_STRUCT_LEN(0x80, =
i40e_aqc_configure_switching_comp_ets_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1421:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_ets_data' is not =
an integer constant
 1421 | I40E_CHECK_STRUCT_LEN(0x80, =
i40e_aqc_configure_switching_comp_ets_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1642:9: error: unknown =
type name 'u8'
 1642 |         u8 oui[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1425:9: error: unknown =
type name 'u8'
 1425 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1643:9: error: unknown =
type name 'u8'
 1643 |         u8 reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1426:9: error: unknown =
type name 'u8'
 1426 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1644:9: error: unknown =
type name 'u8'
 1644 |         u8 part_number[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1427:9: error: unknown =
type name '__le16'
 1427 |         __le16  tc_bw_credit[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1645:9: error: unknown =
type name 'u8'
 1645 |         u8 revision[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1430:9: error: unknown =
type name '__le16'
 1430 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1646:9: error: unknown =
type name 'u8'
 1646 |         u8 reserved2[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1431:9: error: unknown =
type name 'u8'
 1431 |         u8      reserved1[28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1649:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1649 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_module_desc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1434:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1434 | I40E_CHECK_STRUCT_LEN(0x40,
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1435:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_ets_bw_limit_data' =
is not an integer constant
 1435 |                       =
i40e_aqc_configure_switching_comp_ets_bw_limit_data);
      |                       =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1649:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_module_desc' is not an =
integer constant
 1649 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_module_desc);
      |                             ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1441:9: error: unknown =
type name 'u8'
 1441 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1652:9: error: unknown =
type name '__le32'
 1652 |         __le32  phy_type;       /* bitmap using the above enum =
for offsets */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1442:9: error: unknown =
type name 'u8'
 1442 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1443:9: error: unknown =
type name 'u8'
 1443 |         u8      absolute_credits; /* bool */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1653:9: error: unknown =
type name 'u8'
 1653 |         u8      link_speed;     /* bitmap using the above enum =
bit patterns */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1444:9: error: unknown =
type name 'u8'
 1444 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1654:9: error: unknown =
type name 'u8'
 1654 |         u8      abilities;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1445:9: error: unknown =
type name 'u8'
 1445 |         u8      reserved1[20];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1657:9: error: unknown =
type name '__le16'
 1657 |         __le16  eee_capability;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1448:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1448 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_configure_switching_comp_bw_config_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1658:9: error: unknown =
type name '__le32'
 1658 |         __le32  eeer_val;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1448:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_switching_comp_bw_config_data' is =
not an integer constant
 1448 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_configure_switching_comp_bw_config_data);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1659:9: error: unknown =
type name 'u8'
 1659 |         u8      d3_lpan;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1452:9: error: unknown =
type name 'u8'
 1452 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1660:9: error: unknown =
type name 'u8'
 1660 |         u8      phy_type_ext;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1453:9: error: unknown =
type name 'u8'
 1453 |         u8      reserved[35];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1665:9: error: unknown =
type name 'u8'
 1665 |         u8      fec_cfg_curr_mod_ext_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1454:9: error: unknown =
type name '__le16'
 1454 |         __le16  port_bw_limit;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1670:9: error: unknown =
type name 'u8'
 1670 |         u8      ext_comp_code;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1455:9: error: unknown =
type name 'u8'
 1455 |         u8      reserved1[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1671:9: error: unknown =
type name 'u8'
 1671 |         u8      phy_id[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1456:9: error: unknown =
type name 'u8'
 1456 |         u8      tc_bw_max; /* 0-3, limit =3D 2^max */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1457:9: error: unknown =
type name 'u8'
 1457 |         u8      reserved2[23];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1672:9: error: unknown =
type name 'u8'
 1672 |         u8      module_type[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1460:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1460 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_query_switching_comp_ets_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1673:9: error: unknown =
type name 'u8'
 1673 |         u8      qualified_module_count;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1460:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_switching_comp_ets_config_resp' is =
not an integer constant
 1460 | I40E_CHECK_STRUCT_LEN(0x40, =
i40e_aqc_query_switching_comp_ets_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1678:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1678 | I40E_CHECK_STRUCT_LEN(0x218, i40e_aq_get_phy_abilities_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1464:9: error: unknown =
type name 'u8'
 1464 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1678:30: error: =
enumerator value for 'i40e_static_assert_i40e_aq_get_phy_abilities_resp' =
is not an integer constant
 1678 | I40E_CHECK_STRUCT_LEN(0x218, i40e_aq_get_phy_abilities_resp);
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1465:9: error: unknown =
type name 'u8'
 1465 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1682:9: error: unknown =
type name '__le32'
 1682 |         __le32  phy_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1466:9: error: unknown =
type name 'u8'
 1466 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1467:9: error: unknown =
type name 'u8'
 1467 |         u8      tc_strict_priority_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1683:9: error: unknown =
type name 'u8'
 1683 |         u8      link_speed;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1468:9: error: unknown =
type name 'u8'
 1468 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1684:9: error: unknown =
type name 'u8'
 1684 |         u8      abilities;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1469:9: error: unknown =
type name 'u8'
 1469 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1689:9: error: unknown =
type name '__le16'
 1689 |         __le16  eee_capability;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1470:9: error: unknown =
type name '__le16'
 1470 |         __le16  tc_bw_limits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1690:9: error: unknown =
type name '__le32'
 1690 |         __le32  eeer;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1473:9: error: unknown =
type name '__le16'
 1473 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1474:9: error: unknown =
type name 'u8'
 1474 |         u8      reserved3[32];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1691:9: error: unknown =
type name 'u8'
 1691 |         u8      low_power_ctrl;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1477:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1477 | I40E_CHECK_STRUCT_LEN(0x44, =
i40e_aqc_query_port_ets_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1692:9: error: unknown =
type name 'u8'
 1692 |         u8      phy_type_ext;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1477:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_port_ets_config_resp' is not an =
integer constant
 1477 | I40E_CHECK_STRUCT_LEN(0x44, =
i40e_aqc_query_port_ets_config_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1697:9: error: unknown =
type name 'u8'
 1697 |         u8      fec_config;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1483:9: error: unknown =
type name 'u8'
 1483 |         u8      tc_valid_bits;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1705:9: error: unknown =
type name 'u8'
 1705 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1484:9: error: unknown =
type name 'u8'
 1484 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1485:9: error: unknown =
type name 'u8'
 1485 |         u8      absolute_credits_enable; /* bool */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1486:9: error: unknown =
type name 'u8'
 1486 |         u8      tc_bw_share_credits[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1487:9: error: unknown =
type name '__le16'
 1487 |         __le16  tc_bw_limits[8];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:23: error: =
enumerator value for 'i40e_static_assert_i40e_aq_set_phy_config' is not =
an integer constant
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1490:9: error: unknown =
type name '__le16'
 1490 |         __le16  tc_bw_max[2];
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1712:9: error: unknown =
type name '__le16'
 1712 |         __le16  max_frame_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1493:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1493 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_switching_comp_bw_config_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1713:9: error: unknown =
type name 'u8'
 1713 |         u8      params;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1493:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_query_switching_comp_bw_config_resp' is not =
an integer constant
 1493 | I40E_CHECK_STRUCT_LEN(0x20, =
i40e_aqc_query_switching_comp_bw_config_resp);
      |                             =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1714:9: error: unknown =
type name 'u8'
 1714 |         u8      tx_timer_priority; /* bitmap */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1503:9: error: unknown =
type name '__le16'
 1503 |         __le16  pf_valid_bits;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1715:9: error: unknown =
type name '__le16'
 1715 |         __le16  tx_timer_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1504:9: error: unknown =
type name 'u8'
 1504 |         u8      min_bw[16];      /* guaranteed bandwidth */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1716:9: error: unknown =
type name '__le16'
 1716 |         __le16  fc_refresh_threshold;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1505:9: error: unknown =
type name 'u8'
 1505 |         u8      max_bw[16];      /* bandwidth limit */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1717:9: error: unknown =
type name 'u8'
 1717 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1508:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1508 | I40E_CHECK_STRUCT_LEN(0x22, =
i40e_aqc_configure_partition_bw_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1508:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_configure_partition_bw_data' is not an =
integer constant
 1508 | I40E_CHECK_STRUCT_LEN(0x22, =
i40e_aqc_configure_partition_bw_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1514:9: error: unknown =
type name 'u8'
 1514 |         u8      pm_profile;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1515:9: error: unknown =
type name 'u8'
 1515 |         u8      pe_vf_enabled;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:23: error: =
enumerator value for 'i40e_static_assert_i40e_aq_set_mac_config' is not =
an integer constant
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1516:9: error: unknown =
type name 'u8'
 1516 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1724:9: error: unknown =
type name 'u8'
 1724 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1727:9: error: unknown =
type name 'u8'
 1727 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aq_get_set_hmc_resource_profile' is not an =
integer constant
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1519:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1519 | I40E_CHECK_CMD_LENGTH(i40e_aq_get_set_hmc_resource_profile);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_link_restart_an' =
is not an integer constant
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1642:9: error: unknown =
type name 'u8'
 1642 |         u8 oui[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1734:9: error: unknown =
type name '__le16'
 1734 |         __le16  command_flags; /* only field set on command */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1643:9: error: unknown =
type name 'u8'
 1643 |         u8 reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1644:9: error: unknown =
type name 'u8'
 1644 |         u8 part_number[16];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1739:9: error: unknown =
type name 'u8'
 1739 |         u8      phy_type;    /* i40e_aq_phy_type   */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1645:9: error: unknown =
type name 'u8'
 1645 |         u8 revision[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1740:9: error: unknown =
type name 'u8'
 1740 |         u8      link_speed;  /* i40e_aq_link_speed */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1646:9: error: unknown =
type name 'u8'
 1646 |         u8 reserved2[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1741:9: error: unknown =
type name 'u8'
 1741 |         u8      link_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1649:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1649 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_module_desc);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1744:9: error: unknown =
type name 'u8'
 1744 |         u8      an_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1749:9: error: unknown =
type name 'u8'
 1749 |         u8      ext_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1649:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_module_desc' is not an =
integer constant
 1649 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_module_desc);
      |                             ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1750:9: error: unknown =
type name 'u8'
 1750 |         u8      loopback; /* use defines from =
i40e_aqc_set_lb_mode */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1652:9: error: unknown =
type name '__le32'
 1652 |         __le32  phy_type;       /* bitmap using the above enum =
for offsets */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1753:9: error: unknown =
type name '__le16'
 1753 |         __le16  max_frame_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1653:9: error: unknown =
type name 'u8'
 1653 |         u8      link_speed;     /* bitmap using the above enum =
bit patterns */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1654:9: error: unknown =
type name 'u8'
 1654 |         u8      abilities;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1754:9: error: unknown =
type name 'u8'
 1754 |         u8      config;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1657:9: error: unknown =
type name '__le16'
 1657 |         __le16  eee_capability;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1761:25: error: =
unknown type name 'u8'
 1761 |                         u8      power_desc;
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1658:9: error: unknown =
type name '__le32'
 1658 |         __le32  eeer_val;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1762:25: error: =
unknown type name 'u8'
 1762 |                         u8      reserved[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1659:9: error: unknown =
type name 'u8'
 1659 |         u8      d3_lpan;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1765:25: error: =
unknown type name 'u8'
 1765 |                         u8      link_type[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1660:9: error: unknown =
type name 'u8'
 1660 |         u8      phy_type_ext;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1766:25: error: =
unknown type name 'u8'
 1766 |                         u8      link_type_ext;
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1665:9: error: unknown =
type name 'u8'
 1665 |         u8      fec_cfg_curr_mod_ext_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1670:9: error: unknown =
type name 'u8'
 1670 |         u8      ext_comp_code;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1671:9: error: unknown =
type name 'u8'
 1671 |         u8      phy_id[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1672:9: error: unknown =
type name 'u8'
 1672 |         u8      module_type[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is =
not an integer constant
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1673:9: error: unknown =
type name 'u8'
 1673 |         u8      qualified_module_count;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1775:9: error: unknown =
type name 'u8'
 1775 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1678:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1678 | I40E_CHECK_STRUCT_LEN(0x218, i40e_aq_get_phy_abilities_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1776:9: error: unknown =
type name '__le16'
 1776 |         __le16  event_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1780:9: error: unknown =
type name 'u8'
 1780 |         u8      reserved1[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1678:30: error: =
enumerator value for 'i40e_static_assert_i40e_aq_get_phy_abilities_resp' =
is not an integer constant
 1678 | I40E_CHECK_STRUCT_LEN(0x218, i40e_aq_get_phy_abilities_resp);
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1682:9: error: unknown =
type name '__le32'
 1682 |         __le32  phy_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1683:9: error: unknown =
type name 'u8'
 1683 |         u8      link_speed;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1684:9: error: unknown =
type name 'u8'
 1684 |         u8      abilities;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_phy_int_mask' is =
not an integer constant
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1689:9: error: unknown =
type name '__le16'
 1689 |         __le16  eee_capability;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1790:9: error: unknown =
type name '__le32'
 1790 |         __le32  local_an_reg0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1690:9: error: unknown =
type name '__le32'
 1690 |         __le32  eeer;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1791:9: error: unknown =
type name '__le16'
 1791 |         __le16  local_an_reg1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1691:9: error: unknown =
type name 'u8'
 1691 |         u8      low_power_ctrl;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1792:9: error: unknown =
type name 'u8'
 1792 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1692:9: error: unknown =
type name 'u8'
 1692 |         u8      phy_type_ext;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1697:9: error: unknown =
type name 'u8'
 1697 |         u8      fec_config;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1705:9: error: unknown =
type name 'u8'
 1705 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_an_advt_reg' is not an =
integer constant
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1799:9: error: unknown =
type name '__le16'
 1799 |         __le16  lb_mode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:23: error: =
enumerator value for 'i40e_static_assert_i40e_aq_set_phy_config' is not =
an integer constant
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1708:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1708 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_phy_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1805:9: error: unknown =
type name 'u8'
 1805 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1712:9: error: unknown =
type name '__le16'
 1712 |         __le16  max_frame_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1713:9: error: unknown =
type name 'u8'
 1713 |         u8      params;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1714:9: error: unknown =
type name 'u8'
 1714 |         u8      tx_timer_priority; /* bitmap */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_lb_mode' is not an =
integer constant
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1715:9: error: unknown =
type name '__le16'
 1715 |         __le16  tx_timer_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1812:9: error: unknown =
type name 'u8'
 1812 |         u8      command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1716:9: error: unknown =
type name '__le16'
 1716 |         __le16  fc_refresh_threshold;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1717:9: error: unknown =
type name 'u8'
 1717 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1817:9: error: unknown =
type name 'u8'
 1817 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:23: error: =
enumerator value for 'i40e_static_assert_i40e_aq_set_mac_config' is not =
an integer constant
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1720:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1720 | I40E_CHECK_CMD_LENGTH(i40e_aq_set_mac_config);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_phy_debug' is not =
an integer constant
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1724:9: error: unknown =
type name 'u8'
 1724 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1830:9: error: unknown =
type name '__le16'
 1830 |         __le16  activity_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1727:9: error: unknown =
type name 'u8'
 1727 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1831:9: error: unknown =
type name 'u8'
 1831 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1832:9: error: unknown =
type name 'u8'
 1832 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1833:9: error: unknown =
type name '__le32'
 1833 |         __le32  control;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_link_restart_an' =
is not an integer constant
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1730:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1730 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_link_restart_an);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1834:9: error: unknown =
type name '__le32'
 1834 |         __le32  data;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1734:9: error: unknown =
type name '__le16'
 1734 |         __le16  command_flags; /* only field set on command */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1835:9: error: unknown =
type name 'u8'
 1835 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1739:9: error: unknown =
type name 'u8'
 1739 |         u8      phy_type;    /* i40e_aq_phy_type   */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1740:9: error: unknown =
type name 'u8'
 1740 |         u8      link_speed;  /* i40e_aq_link_speed */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1741:9: error: unknown =
type name 'u8'
 1741 |         u8      link_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_run_phy_activity' is =
not an integer constant
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1744:9: error: unknown =
type name 'u8'
 1744 |         u8      an_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1843:9: error: unknown =
type name 'u8'
 1843 |         u8      phy_interface;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1846:9: error: unknown =
type name 'u8'
 1846 |         u8      dev_address;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1749:9: error: unknown =
type name 'u8'
 1749 |         u8      ext_info;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1847:9: error: unknown =
type name 'u8'
 1847 |         u8      cmd_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1750:9: error: unknown =
type name 'u8'
 1750 |         u8      loopback; /* use defines from =
i40e_aqc_set_lb_mode */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1853:9: error: unknown =
type name 'u8'
 1853 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1753:9: error: unknown =
type name '__le16'
 1753 |         __le16  max_frame_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1854:9: error: unknown =
type name '__le32'
 1854 |         __le32  reg_address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1754:9: error: unknown =
type name 'u8'
 1754 |         u8      config;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1855:9: error: unknown =
type name '__le32'
 1855 |         __le32  reg_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1761:25: error: =
unknown type name 'u8'
 1761 |                         u8      power_desc;
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1856:9: error: unknown =
type name 'u8'
 1856 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1762:25: error: =
unknown type name 'u8'
 1762 |                         u8      reserved[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1765:25: error: =
unknown type name 'u8'
 1765 |                         u8      link_type[4];
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1766:25: error: =
unknown type name 'u8'
 1766 |                         u8      link_type_ext;
      |                         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_phy_register_access' =
is not an integer constant
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1866:9: error: unknown =
type name 'u8'
 1866 |         u8      command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1873:9: error: unknown =
type name 'u8'
 1873 |         u8      module_pointer;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_link_status' is =
not an integer constant
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1771:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1771 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_link_status);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1874:9: error: unknown =
type name '__le16'
 1874 |         __le16  length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1775:9: error: unknown =
type name 'u8'
 1775 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1875:9: error: unknown =
type name '__le32'
 1875 |         __le32  offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1776:9: error: unknown =
type name '__le16'
 1776 |         __le16  event_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1876:9: error: unknown =
type name '__le32'
 1876 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1780:9: error: unknown =
type name 'u8'
 1780 |         u8      reserved1[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1877:9: error: unknown =
type name '__le32'
 1877 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_phy_int_mask' is =
not an integer constant
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1783:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1783 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_int_mask);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1790:9: error: unknown =
type name '__le32'
 1790 |         __le32  local_an_reg0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_update' is not an =
integer constant
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1791:9: error: unknown =
type name '__le16'
 1791 |         __le16  local_an_reg1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1884:9: error: unknown =
type name '__le16'
 1884 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1792:9: error: unknown =
type name 'u8'
 1792 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1885:9: error: unknown =
type name '__le16'
 1885 |         __le16  element_count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1886:9: error: unknown =
type name '__le16'
 1886 |         __le16  element_id;     /* Feature/field ID */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1887:9: error: unknown =
type name '__le16'
 1887 |         __le16  element_id_msw; /* MSWord of field ID */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_an_advt_reg' is not an =
integer constant
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1795:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1795 | I40E_CHECK_CMD_LENGTH(i40e_aqc_an_advt_reg);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1888:9: error: unknown =
type name '__le32'
 1888 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1799:9: error: unknown =
type name '__le16'
 1799 |         __le16  lb_mode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1889:9: error: unknown =
type name '__le32'
 1889 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1805:9: error: unknown =
type name 'u8'
 1805 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_read' is =
not an integer constant
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_lb_mode' is not an =
integer constant
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1808:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1808 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_lb_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1812:9: error: unknown =
type name 'u8'
 1812 |         u8      command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1896:9: error: unknown =
type name '__le16'
 1896 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1817:9: error: unknown =
type name 'u8'
 1817 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1897:9: error: unknown =
type name '__le16'
 1897 |         __le16  element_count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1898:9: error: unknown =
type name 'u8'
 1898 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1899:9: error: unknown =
type name '__le32'
 1899 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1900:9: error: unknown =
type name '__le32'
 1900 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_phy_debug' is not =
an integer constant
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1820:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1820 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_phy_debug);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1830:9: error: unknown =
type name '__le16'
 1830 |         __le16  activity_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1831:9: error: unknown =
type name 'u8'
 1831 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1832:9: error: unknown =
type name 'u8'
 1832 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_write' is =
not an integer constant
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1833:9: error: unknown =
type name '__le32'
 1833 |         __le32  control;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1907:9: error: unknown =
type name '__le16'
 1907 |         __le16 feature_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1834:9: error: unknown =
type name '__le32'
 1834 |         __le32  data;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:9: error: unknown =
type name '__le16'
 1908 |         __le16 feature_options;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1835:9: error: unknown =
type name 'u8'
 1835 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1909:9: error: unknown =
type name '__le16'
 1909 |         __le16 feature_selection;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1912:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1912 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_run_phy_activity' is =
not an integer constant
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1838:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1838 | I40E_CHECK_CMD_LENGTH(i40e_aqc_run_phy_activity);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1912:28: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer =
constant
 1912 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1843:9: error: unknown =
type name 'u8'
 1843 |         u8      phy_interface;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1915:9: error: unknown =
type name '__le32'
 1915 |         __le32 field_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1846:9: error: unknown =
type name 'u8'
 1846 |         u8      dev_address;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1916:9: error: unknown =
type name '__le32'
 1916 |         __le32 field_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1847:9: error: unknown =
type name 'u8'
 1847 |         u8      cmd_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1917:9: error: unknown =
type name '__le16'
 1917 |         __le16 field_options;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1853:9: error: unknown =
type name 'u8'
 1853 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1918:9: error: unknown =
type name '__le16'
 1918 |         __le16 reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1854:9: error: unknown =
type name '__le32'
 1854 |         __le32  reg_address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1921:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1921 | I40E_CHECK_STRUCT_LEN(0xc, =
i40e_aqc_nvm_config_data_immediate_field);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1855:9: error: unknown =
type name '__le32'
 1855 |         __le32  reg_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1856:9: error: unknown =
type name 'u8'
 1856 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1921:28: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_config_data_immediate_field' is not an =
integer constant
 1921 | I40E_CHECK_STRUCT_LEN(0xc, =
i40e_aqc_nvm_config_data_immediate_field);
      |                            =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1927:9: error: unknown =
type name 'u8'
 1927 |         u8 sel_data;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1928:9: error: unknown =
type name 'u8'
 1928 |         u8 reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_phy_register_access' =
is not an integer constant
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1859:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1859 | I40E_CHECK_CMD_LENGTH(i40e_aqc_phy_register_access);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1931:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1931 | I40E_CHECK_STRUCT_LEN(0x8, i40e_aqc_nvm_oem_post_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1866:9: error: unknown =
type name 'u8'
 1866 |         u8      command_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1931:28: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_oem_post_update' =
is not an integer constant
 1931 | I40E_CHECK_STRUCT_LEN(0x8, i40e_aqc_nvm_oem_post_update);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1873:9: error: unknown =
type name 'u8'
 1873 |         u8      module_pointer;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1934:9: error: unknown =
type name 'u8'
 1934 |         u8 str_len;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1874:9: error: unknown =
type name '__le16'
 1874 |         __le16  length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1935:9: error: unknown =
type name 'u8'
 1935 |         u8 dev_addr;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1875:9: error: unknown =
type name '__le32'
 1875 |         __le32  offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1876:9: error: unknown =
type name '__le32'
 1876 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1936:9: error: unknown =
type name '__le16'
 1936 |         __le16 eeprom_addr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1877:9: error: unknown =
type name '__le32'
 1877 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1937:9: error: unknown =
type name 'u8'
 1937 |         u8 data[36];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1940:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1940 | I40E_CHECK_STRUCT_LEN(0x28, =
i40e_aqc_nvm_oem_post_update_buffer);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1940:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_oem_post_update_buffer' is not an =
integer constant
 1940 | I40E_CHECK_STRUCT_LEN(0x28, =
i40e_aqc_nvm_oem_post_update_buffer);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_update' is not an =
integer constant
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1880:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1880 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1947:9: error: unknown =
type name 'u8'
 1947 |         u8 sensor_action;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1884:9: error: unknown =
type name '__le16'
 1884 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1948:9: error: unknown =
type name 'u8'
 1948 |         u8 reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1885:9: error: unknown =
type name '__le16'
 1885 |         __le16  element_count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1949:9: error: unknown =
type name '__le32'
 1949 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1886:9: error: unknown =
type name '__le16'
 1886 |         __le16  element_id;     /* Feature/field ID */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1950:9: error: unknown =
type name '__le32'
 1950 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1887:9: error: unknown =
type name '__le16'
 1887 |         __le16  element_id_msw; /* MSWord of field ID */
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1888:9: error: unknown =
type name '__le32'
 1888 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1889:9: error: unknown =
type name '__le32'
 1889 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_thermal_sensor' is not =
an integer constant
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1960:9: error: unknown =
type name '__le32'
 1960 |         __le32  id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_read' is =
not an integer constant
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1892:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1892 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_read);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1961:9: error: unknown =
type name 'u8'
 1961 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1896:9: error: unknown =
type name '__le16'
 1896 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1962:9: error: unknown =
type name '__le32'
 1962 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1897:9: error: unknown =
type name '__le16'
 1897 |         __le16  element_count;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1963:9: error: unknown =
type name '__le32'
 1963 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1898:9: error: unknown =
type name 'u8'
 1898 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1899:9: error: unknown =
type name '__le32'
 1899 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1900:9: error: unknown =
type name '__le32'
 1900 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_pf_vf_message' is not =
an integer constant
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1974:9: error: unknown =
type name '__le32'
 1974 |         __le32 address0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_config_write' is =
not an integer constant
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1903:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1903 | I40E_CHECK_CMD_LENGTH(i40e_aqc_nvm_config_write);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1975:9: error: unknown =
type name '__le32'
 1975 |         __le32 data0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1907:9: error: unknown =
type name '__le16'
 1907 |         __le16 feature_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1976:9: error: unknown =
type name '__le32'
 1976 |         __le32 address1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1908:9: error: unknown =
type name '__le16'
 1908 |         __le16 feature_options;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1977:9: error: unknown =
type name '__le32'
 1977 |         __le32 data1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1909:9: error: unknown =
type name '__le16'
 1909 |         __le16 feature_selection;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1987:9: error: unknown =
type name '__le32'
 1987 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1912:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1912 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1988:9: error: unknown =
type name '__le32'
 1988 |         __le32 length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1912:28: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_config_data_feature' is not an integer =
constant
 1912 | I40E_CHECK_STRUCT_LEN(0x6, i40e_aqc_nvm_config_data_feature);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1989:9: error: unknown =
type name '__le32'
 1989 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1915:9: error: unknown =
type name '__le32'
 1915 |         __le32 field_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1990:9: error: unknown =
type name '__le32'
 1990 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1916:9: error: unknown =
type name '__le32'
 1916 |         __le32 field_value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1999:9: error: unknown =
type name '__le16'
 1999 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1917:9: error: unknown =
type name '__le16'
 1917 |         __le16 field_options;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2000:9: error: unknown =
type name 'u8'
 2000 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1918:9: error: unknown =
type name '__le16'
 1918 |         __le16 reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1921:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1921 | I40E_CHECK_STRUCT_LEN(0xc, =
i40e_aqc_nvm_config_data_immediate_field);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1921:28: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_config_data_immediate_field' is not an =
integer constant
 1921 | I40E_CHECK_STRUCT_LEN(0xc, =
i40e_aqc_nvm_config_data_immediate_field);
      |                            =
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_alternate_write_done' =
is not an integer constant
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1927:9: error: unknown =
type name 'u8'
 1927 |         u8 sel_data;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2007:9: error: unknown =
type name '__le32'
 2007 |         __le32  mode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1928:9: error: unknown =
type name 'u8'
 1928 |         u8 reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1931:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1931 | I40E_CHECK_STRUCT_LEN(0x8, i40e_aqc_nvm_oem_post_update);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2008:9: error: unknown =
type name 'u8'
 2008 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1931:28: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_nvm_oem_post_update' =
is not an integer constant
 1931 | I40E_CHECK_STRUCT_LEN(0x8, i40e_aqc_nvm_oem_post_update);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1934:9: error: unknown =
type name 'u8'
 1934 |         u8 str_len;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1935:9: error: unknown =
type name 'u8'
 1935 |         u8 dev_addr;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_alternate_set_mode' is =
not an integer constant
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1936:9: error: unknown =
type name '__le16'
 1936 |         __le16 eeprom_addr;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2019:9: error: unknown =
type name '__le32'
 2019 |         __le32  prtdcb_rupto;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1937:9: error: unknown =
type name 'u8'
 1937 |         u8 data[36];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2020:9: error: unknown =
type name '__le32'
 2020 |         __le32  otx_ctl;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1940:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 1940 | I40E_CHECK_STRUCT_LEN(0x28, =
i40e_aqc_nvm_oem_post_update_buffer);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2021:9: error: unknown =
type name 'u8'
 2021 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1940:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_nvm_oem_post_update_buffer' is not an =
integer constant
 1940 | I40E_CHECK_STRUCT_LEN(0x28, =
i40e_aqc_nvm_oem_post_update_buffer);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1947:9: error: unknown =
type name 'u8'
 1947 |         u8 sensor_action;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1948:9: error: unknown =
type name 'u8'
 1948 |         u8 reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lan_overflow' is not =
an integer constant
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1949:9: error: unknown =
type name '__le32'
 1949 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2028:9: error: unknown =
type name 'u8'
 2028 |         u8      type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1950:9: error: unknown =
type name '__le32'
 1950 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2029:9: error: unknown =
type name 'u8'
 2029 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2037:9: error: unknown =
type name '__le16'
 2037 |         __le16  local_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2038:9: error: unknown =
type name '__le16'
 2038 |         __le16  remote_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_thermal_sensor' is not =
an integer constant
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1953:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1953 | I40E_CHECK_CMD_LENGTH(i40e_aqc_thermal_sensor);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2039:9: error: unknown =
type name 'u8'
 2039 |         u8      reserved2[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1960:9: error: unknown =
type name '__le32'
 1960 |         __le32  id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2040:9: error: unknown =
type name '__le32'
 2040 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1961:9: error: unknown =
type name 'u8'
 1961 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2041:9: error: unknown =
type name '__le32'
 2041 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1962:9: error: unknown =
type name '__le32'
 1962 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1963:9: error: unknown =
type name '__le32'
 1963 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_get_mib' is not =
an integer constant
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_pf_vf_message' is not =
an integer constant
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1966:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 1966 | I40E_CHECK_CMD_LENGTH(i40e_aqc_pf_vf_message);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2050:9: error: unknown =
type name 'u8'
 2050 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1974:9: error: unknown =
type name '__le32'
 1974 |         __le32 address0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2052:9: error: unknown =
type name 'u8'
 2052 |         u8      reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1975:9: error: unknown =
type name '__le32'
 1975 |         __le32 data0;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2053:9: error: unknown =
type name '__le32'
 2053 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1976:9: error: unknown =
type name '__le32'
 1976 |         __le32 address1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2054:9: error: unknown =
type name '__le32'
 2054 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1977:9: error: unknown =
type name '__le32'
 1977 |         __le32 data1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1987:9: error: unknown =
type name '__le32'
 1987 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1988:9: error: unknown =
type name '__le32'
 1988 |         __le32 length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1989:9: error: unknown =
type name '__le32'
 1989 |         __le32 addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_update_mib' is =
not an integer constant
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1990:9: error: unknown =
type name '__le32'
 1990 |         __le32 addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2063:9: error: unknown =
type name 'u8'
 2063 |         u8      type; /* only nearest bridge and non-TPMR from =
0x0A00 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:1999:9: error: unknown =
type name '__le16'
 1999 |         __le16  cmd_flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2064:9: error: unknown =
type name 'u8'
 2064 |         u8      reserved1[1];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2000:9: error: unknown =
type name 'u8'
 2000 |         u8      reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2065:9: error: unknown =
type name '__le16'
 2065 |         __le16  len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2066:9: error: unknown =
type name 'u8'
 2066 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2067:9: error: unknown =
type name '__le32'
 2067 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_alternate_write_done' =
is not an integer constant
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2003:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2003 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_write_done);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2007:9: error: unknown =
type name '__le32'
 2007 |         __le32  mode;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2068:9: error: unknown =
type name '__le32'
 2068 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2008:9: error: unknown =
type name 'u8'
 2008 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_add_tlv' is not =
an integer constant
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_alternate_set_mode' is =
not an integer constant
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2011:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2011 | I40E_CHECK_CMD_LENGTH(i40e_aqc_alternate_set_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2075:9: error: unknown =
type name 'u8'
 2075 |         u8      type; /* only nearest bridge and non-TPMR from =
0x0A00 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2019:9: error: unknown =
type name '__le32'
 2019 |         __le32  prtdcb_rupto;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2076:9: error: unknown =
type name 'u8'
 2076 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2020:9: error: unknown =
type name '__le32'
 2020 |         __le32  otx_ctl;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2077:9: error: unknown =
type name '__le16'
 2077 |         __le16  old_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2021:9: error: unknown =
type name 'u8'
 2021 |         u8      reserved[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2078:9: error: unknown =
type name '__le16'
 2078 |         __le16  new_offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2079:9: error: unknown =
type name '__le16'
 2079 |         __le16  new_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2080:9: error: unknown =
type name '__le32'
 2080 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lan_overflow' is not =
an integer constant
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2024:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2024 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lan_overflow);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2081:9: error: unknown =
type name '__le32'
 2081 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2028:9: error: unknown =
type name 'u8'
 2028 |         u8      type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2029:9: error: unknown =
type name 'u8'
 2029 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2037:9: error: unknown =
type name '__le16'
 2037 |         __le16  local_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_update_tlv' is =
not an integer constant
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2038:9: error: unknown =
type name '__le16'
 2038 |         __le16  remote_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2088:9: error: unknown =
type name 'u8'
 2088 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2039:9: error: unknown =
type name 'u8'
 2039 |         u8      reserved2[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2091:9: error: unknown =
type name 'u8'
 2091 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2040:9: error: unknown =
type name '__le32'
 2040 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2041:9: error: unknown =
type name '__le32'
 2041 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_stop' is not an =
integer constant
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      |                       ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_get_mib' is not =
an integer constant
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2044:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2044 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_get_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2098:9: error: unknown =
type name 'u8'
 2098 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2050:9: error: unknown =
type name 'u8'
 2050 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2101:9: error: unknown =
type name 'u8'
 2101 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2052:9: error: unknown =
type name 'u8'
 2052 |         u8      reserved[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2053:9: error: unknown =
type name '__le32'
 2053 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2054:9: error: unknown =
type name '__le32'
 2054 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_start' is not an =
integer constant
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2108:9: error: unknown =
type name 'u8'
 2108 |         u8 command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2111:9: error: unknown =
type name 'u8'
 2111 |         u8 valid_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_update_mib' is =
not an integer constant
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2057:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2057 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2112:9: error: unknown =
type name 'u8'
 2112 |         u8 reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2063:9: error: unknown =
type name 'u8'
 2063 |         u8      type; /* only nearest bridge and non-TPMR from =
0x0A00 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2064:9: error: unknown =
type name 'u8'
 2064 |         u8      reserved1[1];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2065:9: error: unknown =
type name '__le16'
 2065 |         __le16  len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2066:9: error: unknown =
type name 'u8'
 2066 |         u8      reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_dcb_parameters' is =
not an integer constant
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2067:9: error: unknown =
type name '__le32'
 2067 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2151:9: error: unknown =
type name 'u8'
 2151 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2068:9: error: unknown =
type name '__le32'
 2068 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2152:9: error: unknown =
type name 'u8'
 2152 |         u8      oper_num_tc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2153:9: error: unknown =
type name 'u8'
 2153 |         u8      oper_prio_tc[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2154:9: error: unknown =
type name 'u8'
 2154 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_add_tlv' is not =
an integer constant
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2071:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2071 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_add_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2155:9: error: unknown =
type name 'u8'
 2155 |         u8      oper_tc_bw[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2075:9: error: unknown =
type name 'u8'
 2075 |         u8      type; /* only nearest bridge and non-TPMR from =
0x0A00 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2156:9: error: unknown =
type name 'u8'
 2156 |         u8      oper_pfc_en;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2076:9: error: unknown =
type name 'u8'
 2076 |         u8      reserved;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2157:9: error: unknown =
type name 'u8'
 2157 |         u8      reserved3[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2077:9: error: unknown =
type name '__le16'
 2077 |         __le16  old_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2158:9: error: unknown =
type name '__le16'
 2158 |         __le16  oper_app_prio;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2078:9: error: unknown =
type name '__le16'
 2078 |         __le16  new_offset;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2159:9: error: unknown =
type name 'u8'
 2159 |         u8      reserved4[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2079:9: error: unknown =
type name '__le16'
 2079 |         __le16  new_len;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2080:9: error: unknown =
type name '__le32'
 2080 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2160:9: error: unknown =
type name '__le16'
 2160 |         __le16  tlv_status;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2081:9: error: unknown =
type name '__le32'
 2081 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2163:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2163 | I40E_CHECK_STRUCT_LEN(0x18, i40e_aqc_get_cee_dcb_cfg_v1_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2163:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_cee_dcb_cfg_v1_resp' is not an integer =
constant
 2163 | I40E_CHECK_STRUCT_LEN(0x18, i40e_aqc_get_cee_dcb_cfg_v1_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2166:9: error: unknown =
type name 'u8'
 2166 |         u8      oper_num_tc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_update_tlv' is =
not an integer constant
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2084:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2084 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_update_tlv);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2167:9: error: unknown =
type name 'u8'
 2167 |         u8      oper_prio_tc[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2088:9: error: unknown =
type name 'u8'
 2088 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2168:9: error: unknown =
type name 'u8'
 2168 |         u8      oper_tc_bw[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2091:9: error: unknown =
type name 'u8'
 2091 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2169:9: error: unknown =
type name 'u8'
 2169 |         u8      oper_pfc_en;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2170:9: error: unknown =
type name '__le16'
 2170 |         __le16  oper_app_prio;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2178:9: error: unknown =
type name '__le32'
 2178 |         __le32  tlv_status;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_stop' is not an =
integer constant
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      |                       ^~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2094:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2094 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2185:9: error: unknown =
type name 'u8'
 2185 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2098:9: error: unknown =
type name 'u8'
 2098 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2188:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2188 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_cee_dcb_cfg_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2101:9: error: unknown =
type name 'u8'
 2101 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2188:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_cee_dcb_cfg_resp' =
is not an integer constant
 2188 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_cee_dcb_cfg_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2202:9: error: unknown =
type name 'u8'
 2202 |         u8      type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_start' is not an =
integer constant
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      |                       ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2104:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2104 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_start);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2203:9: error: unknown =
type name 'u8'
 2203 |         u8      reserved0;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2204:9: error: unknown =
type name '__le16'
 2204 |         __le16  length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2108:9: error: unknown =
type name 'u8'
 2108 |         u8 command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2205:9: error: unknown =
type name 'u8'
 2205 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2111:9: error: unknown =
type name 'u8'
 2111 |         u8 valid_flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2112:9: error: unknown =
type name 'u8'
 2112 |         u8 reserved[14];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2206:9: error: unknown =
type name '__le32'
 2206 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2207:9: error: unknown =
type name '__le32'
 2207 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_set_dcb_parameters' is =
not an integer constant
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2115:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2115 | I40E_CHECK_CMD_LENGTH(i40e_aqc_set_dcb_parameters);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2151:9: error: unknown =
type name 'u8'
 2151 |         u8      reserved1;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_set_local_mib' is =
not an integer constant
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2152:9: error: unknown =
type name 'u8'
 2152 |         u8      oper_num_tc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2216:9: error: unknown =
type name 'u8'
 2216 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2153:9: error: unknown =
type name 'u8'
 2153 |         u8      oper_prio_tc[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2217:9: error: unknown =
type name 'u8'
 2217 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2154:9: error: unknown =
type name 'u8'
 2154 |         u8      reserved2;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2155:9: error: unknown =
type name 'u8'
 2155 |         u8      oper_tc_bw[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2156:9: error: unknown =
type name 'u8'
 2156 |         u8      oper_pfc_en;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_lldp_stop_start_specific_agent' is not an =
integer constant
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2157:9: error: unknown =
type name 'u8'
 2157 |         u8      reserved3[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2224:9: error: unknown =
type name 'u8'
 2224 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2158:9: error: unknown =
type name '__le16'
 2158 |         __le16  oper_app_prio;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2226:9: error: unknown =
type name 'u8'
 2226 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2159:9: error: unknown =
type name 'u8'
 2159 |         u8      reserved4[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2160:9: error: unknown =
type name '__le16'
 2160 |         __le16  tlv_status;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2163:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2163 | I40E_CHECK_STRUCT_LEN(0x18, i40e_aqc_get_cee_dcb_cfg_v1_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_restore' is not =
an integer constant
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2163:29: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_get_cee_dcb_cfg_v1_resp' is not an integer =
constant
 2163 | I40E_CHECK_STRUCT_LEN(0x18, i40e_aqc_get_cee_dcb_cfg_v1_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2233:9: error: unknown =
type name '__le16'
 2233 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2166:9: error: unknown =
type name 'u8'
 2166 |         u8      oper_num_tc;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2234:9: error: unknown =
type name 'u8'
 2234 |         u8      reserved0[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2167:9: error: unknown =
type name 'u8'
 2167 |         u8      oper_prio_tc[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2168:9: error: unknown =
type name 'u8'
 2168 |         u8      oper_tc_bw[8];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2235:9: error: unknown =
type name 'u8'
 2235 |         u8      protocol_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2169:9: error: unknown =
type name 'u8'
 2169 |         u8      oper_pfc_en;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2238:9: error: unknown =
type name 'u8'
 2238 |         u8      reserved1[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2170:9: error: unknown =
type name '__le16'
 2170 |         __le16  oper_app_prio;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2178:9: error: unknown =
type name '__le32'
 2178 |         __le32  tlv_status;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2185:9: error: unknown =
type name 'u8'
 2185 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_udp_tunnel' is not =
an integer constant
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2188:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2188 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_cee_dcb_cfg_resp);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2244:9: error: unknown =
type name '__le16'
 2244 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2188:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_cee_dcb_cfg_resp' =
is not an integer constant
 2188 | I40E_CHECK_STRUCT_LEN(0x20, i40e_aqc_get_cee_dcb_cfg_resp);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2245:9: error: unknown =
type name 'u8'
 2245 |         u8      filter_entry_index;
      |         ^~
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2202:9: error: =
unknown type name 'u8'
 2202 |         u8      type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2246:9: error: unknown =
type name 'u8'
 2246 |         u8      multiple_pfs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2203:9: error: unknown =
type name 'u8'
 2203 |         u8      reserved0;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2247:9: error: unknown =
type name 'u8'
 2247 |         u8      total_filters;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2204:9: error: unknown =
type name '__le16'
 2204 |         __le16  length;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2248:9: error: unknown =
type name 'u8'
 2248 |         u8      reserved[11];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2205:9: error: unknown =
type name 'u8'
 2205 |         u8      reserved1[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2206:9: error: unknown =
type name '__le32'
 2206 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2207:9: error: unknown =
type name '__le32'
 2207 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_udp_tunnel_completion' is not an =
integer constant
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2255:9: error: unknown =
type name 'u8'
 2255 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2256:9: error: unknown =
type name 'u8'
 2256 |         u8      index; /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_set_local_mib' is =
not an integer constant
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2210:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2210 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_set_local_mib);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2257:9: error: unknown =
type name 'u8'
 2257 |         u8      reserved2[13];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2216:9: error: unknown =
type name 'u8'
 2216 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2217:9: error: unknown =
type name 'u8'
 2217 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_remove_udp_tunnel' is =
not an integer constant
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2263:9: error: unknown =
type name '__le16'
 2263 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_lldp_stop_start_specific_agent' is not an =
integer constant
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2220:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2220 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_stop_start_specific_agent);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2264:9: error: unknown =
type name 'u8'
 2264 |         u8      index; /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2224:9: error: unknown =
type name 'u8'
 2224 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2265:9: error: unknown =
type name 'u8'
 2265 |         u8      multiple_pfs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2226:9: error: unknown =
type name 'u8'
 2226 |         u8      reserved[15];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2266:9: error: unknown =
type name 'u8'
 2266 |         u8      total_filters_used;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2267:9: error: unknown =
type name 'u8'
 2267 |         u8      reserved1[11];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_lldp_restore' is not =
an integer constant
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      |                       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2229:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2229 | I40E_CHECK_CMD_LENGTH(i40e_aqc_lldp_restore);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2233:9: error: unknown =
type name '__le16'
 2233 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_del_udp_tunnel_completion' is not an =
integer constant
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2234:9: error: unknown =
type name 'u8'
 2234 |         u8      reserved0[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2277:9: error: unknown =
type name '__le16'
 2277 |         __le16  vsi_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2235:9: error: unknown =
type name 'u8'
 2235 |         u8      protocol_type;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2278:9: error: unknown =
type name 'u8'
 2278 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2238:9: error: unknown =
type name 'u8'
 2238 |         u8      reserved1[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2279:9: error: unknown =
type name '__le32'
 2279 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2280:9: error: unknown =
type name '__le32'
 2280 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_add_udp_tunnel' is not =
an integer constant
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2241:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2241 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2244:9: error: unknown =
type name '__le16'
 2244 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_key' is =
not an integer constant
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2245:9: error: unknown =
type name 'u8'
 2245 |         u8      filter_entry_index;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2286:9: error: unknown =
type name 'u8'
 2286 |         u8 standard_rss_key[0x28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2246:9: error: unknown =
type name 'u8'
 2246 |         u8      multiple_pfs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2287:9: error: unknown =
type name 'u8'
 2287 |         u8 extended_hash_key[0xc];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2247:9: error: unknown =
type name 'u8'
 2247 |         u8      total_filters;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2290:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2290 | I40E_CHECK_STRUCT_LEN(0x34, i40e_aqc_get_set_rss_key_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2248:9: error: unknown =
type name 'u8'
 2248 |         u8      reserved[11];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2290:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_key_data' =
is not an integer constant
 2290 | I40E_CHECK_STRUCT_LEN(0x34, i40e_aqc_get_set_rss_key_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2297:9: error: unknown =
type name '__le16'
 2297 |         __le16  vsi_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2303:9: error: unknown =
type name '__le16'
 2303 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_add_udp_tunnel_completion' is not an =
integer constant
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2251:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2251 | I40E_CHECK_CMD_LENGTH(i40e_aqc_add_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2304:9: error: unknown =
type name 'u8'
 2304 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2255:9: error: unknown =
type name 'u8'
 2255 |         u8      reserved[2];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2305:9: error: unknown =
type name '__le32'
 2305 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2256:9: error: unknown =
type name 'u8'
 2256 |         u8      index; /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2306:9: error: unknown =
type name '__le32'
 2306 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2257:9: error: unknown =
type name 'u8'
 2257 |         u8      reserved2[13];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_lut' is =
not an integer constant
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_remove_udp_tunnel' is =
not an integer constant
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2260:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2260 | I40E_CHECK_CMD_LENGTH(i40e_aqc_remove_udp_tunnel);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2263:9: error: unknown =
type name '__le16'
 2263 |         __le16  udp_port;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2314:9: error: unknown =
type name 'u8'
 2314 |         u8      key1_off;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2264:9: error: unknown =
type name 'u8'
 2264 |         u8      index; /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2315:9: error: unknown =
type name 'u8'
 2315 |         u8      key2_off;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2265:9: error: unknown =
type name 'u8'
 2265 |         u8      multiple_pfs;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2316:9: error: unknown =
type name 'u8'
 2316 |         u8      key1_len;  /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2266:9: error: unknown =
type name 'u8'
 2266 |         u8      total_filters_used;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2317:9: error: unknown =
type name 'u8'
 2317 |         u8      key2_len;  /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2267:9: error: unknown =
type name 'u8'
 2267 |         u8      reserved1[11];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2318:9: error: unknown =
type name 'u8'
 2318 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2319:9: error: unknown =
type name 'u8'
 2319 |         u8      network_key_index;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2320:9: error: unknown =
type name 'u8'
 2320 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_del_udp_tunnel_completion' is not an =
integer constant
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2270:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2270 | I40E_CHECK_CMD_LENGTH(i40e_aqc_del_udp_tunnel_completion);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2277:9: error: unknown =
type name '__le16'
 2277 |         __le16  vsi_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2278:9: error: unknown =
type name 'u8'
 2278 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_tunnel_key_structure' =
is not an integer constant
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2279:9: error: unknown =
type name '__le32'
 2279 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2327:9: error: unknown =
type name '__le32'
 2327 |         __le32  param_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2280:9: error: unknown =
type name '__le32'
 2280 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2328:9: error: unknown =
type name '__le32'
 2328 |         __le32  param_value1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2329:9: error: unknown =
type name '__le16'
 2329 |         __le16  param_value2;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2330:9: error: unknown =
type name 'u8'
 2330 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_key' is =
not an integer constant
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2283:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2283 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_key);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2286:9: error: unknown =
type name 'u8'
 2286 |         u8 standard_rss_key[0x28];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2287:9: error: unknown =
type name 'u8'
 2287 |         u8 extended_hash_key[0xc];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_oem_param_change' is =
not an integer constant
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2290:1: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
 2290 | I40E_CHECK_STRUCT_LEN(0x34, i40e_aqc_get_set_rss_key_data);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2336:9: error: unknown =
type name '__le32'
 2336 |         __le32  state;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2290:29: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_key_data' =
is not an integer constant
 2290 | I40E_CHECK_STRUCT_LEN(0x34, i40e_aqc_get_set_rss_key_data);
      |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2337:9: error: unknown =
type name 'u8'
 2337 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2297:9: error: unknown =
type name '__le16'
 2297 |         __le16  vsi_id;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2303:9: error: unknown =
type name '__le16'
 2303 |         __le16  flags;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2304:9: error: unknown =
type name 'u8'
 2304 |         u8      reserved[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_oem_state_change' is =
not an integer constant
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2305:9: error: unknown =
type name '__le32'
 2305 |         __le32  addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2344:9: error: unknown =
type name 'u8'
 2344 |         u8 type_status;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2306:9: error: unknown =
type name '__le32'
 2306 |         __le32  addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2345:9: error: unknown =
type name 'u8'
 2345 |         u8 reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2346:9: error: unknown =
type name '__le32'
 2346 |         __le32 ocsd_memory_block_addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2347:9: error: unknown =
type name '__le32'
 2347 |         __le32 ocsd_memory_block_addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_get_set_rss_lut' is =
not an integer constant
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2309:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2309 | I40E_CHECK_CMD_LENGTH(i40e_aqc_get_set_rss_lut);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2348:9: error: unknown =
type name '__le32'
 2348 |         __le32 requested_update_interval;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2314:9: error: unknown =
type name 'u8'
 2314 |         u8      key1_off;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2315:9: error: unknown =
type name 'u8'
 2315 |         u8      key2_off;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2316:9: error: unknown =
type name 'u8'
 2316 |         u8      key1_len;  /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_opc_oem_ocsd_initialize' is not an integer =
constant
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2317:9: error: unknown =
type name 'u8'
 2317 |         u8      key2_len;  /* 0 to 15 */
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2355:9: error: unknown =
type name 'u8'
 2355 |         u8 type_status;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2318:9: error: unknown =
type name 'u8'
 2318 |         u8      flags;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2356:9: error: unknown =
type name 'u8'
 2356 |         u8 reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2319:9: error: unknown =
type name 'u8'
 2319 |         u8      network_key_index;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2357:9: error: unknown =
type name '__le32'
 2357 |         __le32 ocbb_memory_block_addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2320:9: error: unknown =
type name 'u8'
 2320 |         u8      reserved[10];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2358:9: error: unknown =
type name '__le32'
 2358 |         __le32 ocbb_memory_block_addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2359:9: error: unknown =
type name 'u8'
 2359 |         u8 reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_tunnel_key_structure' =
is not an integer constant
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2323:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2323 | I40E_CHECK_CMD_LENGTH(i40e_aqc_tunnel_key_structure);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2327:9: error: unknown =
type name '__le32'
 2327 |         __le32  param_type;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_opc_oem_ocbb_initialize' is not an integer =
constant
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2328:9: error: unknown =
type name '__le32'
 2328 |         __le32  param_value1;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2371:9: error: unknown =
type name 'u8'
 2371 |         u8      mode;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2329:9: error: unknown =
type name '__le16'
 2329 |         __le16  param_value2;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2372:9: error: unknown =
type name 'u8'
 2372 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2330:9: error: unknown =
type name 'u8'
 2330 |         u8      reserved[6];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2373:9: error: unknown =
type name 'u8'
 2373 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2374:9: error: unknown =
type name 'u8'
 2374 |         u8      reserved2[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2375:9: error: unknown =
type name '__le32'
 2375 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_oem_param_change' is =
not an integer constant
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2333:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2333 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_param_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2376:9: error: unknown =
type name '__le32'
 2376 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2336:9: error: unknown =
type name '__le32'
 2336 |         __le32  state;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2337:9: error: unknown =
type name 'u8'
 2337 |         u8      reserved[12];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:23: error: =
enumerator value for 'i40e_static_assert_i40e_acq_set_test_mode' is not =
an integer constant
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_oem_state_change' is =
not an integer constant
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2340:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2340 | I40E_CHECK_CMD_LENGTH(i40e_aqc_oem_state_change);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2385:9: error: unknown =
type name '__le32'
 2385 |         __le32 reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2344:9: error: unknown =
type name 'u8'
 2344 |         u8 type_status;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2386:9: error: unknown =
type name '__le32'
 2386 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2345:9: error: unknown =
type name 'u8'
 2345 |         u8 reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2387:9: error: unknown =
type name '__le32'
 2387 |         __le32 value_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2346:9: error: unknown =
type name '__le32'
 2346 |         __le32 ocsd_memory_block_addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2388:9: error: unknown =
type name '__le32'
 2388 |         __le32 value_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2347:9: error: unknown =
type name '__le32'
 2347 |         __le32 ocsd_memory_block_addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2399:9: error: unknown =
type name '__le32'
 2399 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2348:9: error: unknown =
type name '__le32'
 2348 |         __le32 requested_update_interval;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2400:9: error: unknown =
type name '__le32'
 2400 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2405:9: error: unknown =
type name '__le32'
 2405 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2406:9: error: unknown =
type name '__le32'
 2406 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_opc_oem_ocsd_initialize' is not an integer =
constant
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2351:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2351 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocsd_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2407:9: error: unknown =
type name '__le32'
 2407 |         __le32 clear_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2355:9: error: unknown =
type name 'u8'
 2355 |         u8 type_status;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2408:9: error: unknown =
type name '__le32'
 2408 |         __le32 set_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2356:9: error: unknown =
type name 'u8'
 2356 |         u8 reserved1[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2415:9: error: unknown =
type name 'u8'
 2415 |         u8      cluster_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2357:9: error: unknown =
type name '__le32'
 2357 |         __le32 ocbb_memory_block_addr_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2416:9: error: unknown =
type name 'u8'
 2416 |         u8      table_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2358:9: error: unknown =
type name '__le32'
 2358 |         __le32 ocbb_memory_block_addr_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2417:9: error: unknown =
type name '__le16'
 2417 |         __le16  data_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2359:9: error: unknown =
type name 'u8'
 2359 |         u8 reserved2[4];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2418:9: error: unknown =
type name '__le32'
 2418 |         __le32  idx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2419:9: error: unknown =
type name '__le32'
 2419 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2420:9: error: unknown =
type name '__le32'
 2420 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_opc_oem_ocbb_initialize' is not an integer =
constant
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2362:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2362 | I40E_CHECK_CMD_LENGTH(i40e_aqc_opc_oem_ocbb_initialize);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2371:9: error: unknown =
type name 'u8'
 2371 |         u8      mode;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2372:9: error: unknown =
type name 'u8'
 2372 |         u8      reserved[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_debug_dump_internals' =
is not an integer constant
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2373:9: error: unknown =
type name 'u8'
 2373 |         u8      command;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2426:9: error: unknown =
type name 'u8'
 2426 |         u8      cluster_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2374:9: error: unknown =
type name 'u8'
 2374 |         u8      reserved2[3];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2427:9: error: unknown =
type name 'u8'
 2427 |         u8      cluster_specific_params[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2375:9: error: unknown =
type name '__le32'
 2375 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2428:9: error: unknown =
type name '__le32'
 2428 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2376:9: error: unknown =
type name '__le32'
 2376 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2429:9: error: unknown =
type name '__le32'
 2429 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:23: error: =
enumerator value for 'i40e_static_assert_i40e_acq_set_test_mode' is not =
an integer constant
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      |                       ^~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2379:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2379 | I40E_CHECK_CMD_LENGTH(i40e_acq_set_test_mode);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_debug_modify_internals' is not an integer =
constant
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:20:9: error: unknown type =
name 'u32'
   20 |         u32 offset;     /* the base register */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:21:9: error: unknown type =
name 'u32'
   21 |         u32 mask;       /* bits that can be tested */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type =
name 'u32'
   22 |         u32 elements;   /* number of elements if array */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type =
name 'u32'
   23 |         u32 stride;     /* bytes between each element */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2385:9: error: unknown =
type name '__le32'
 2385 |         __le32 reserved;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2386:9: error: unknown =
type name '__le32'
 2386 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2387:9: error: unknown =
type name '__le32'
 2387 |         __le32 value_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2388:9: error: unknown =
type name '__le32'
 2388 |         __le32 value_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2399:9: error: unknown =
type name '__le32'
 2399 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2400:9: error: unknown =
type name '__le32'
 2400 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2405:9: error: unknown =
type name '__le32'
 2405 |         __le32 address;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2406:9: error: unknown =
type name '__le32'
 2406 |         __le32 value;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2407:9: error: unknown =
type name '__le32'
 2407 |         __le32 clear_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2408:9: error: unknown =
type name '__le32'
 2408 |         __le32 set_mask;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2415:9: error: unknown =
type name 'u8'
 2415 |         u8      cluster_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2416:9: error: unknown =
type name 'u8'
 2416 |         u8      table_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2417:9: error: unknown =
type name '__le16'
 2417 |         __le16  data_size;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2418:9: error: unknown =
type name '__le32'
 2418 |         __le32  idx;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2419:9: error: unknown =
type name '__le32'
 2419 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2420:9: error: unknown =
type name '__le32'
 2420 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:23: error: =
enumerator value for 'i40e_static_assert_i40e_aqc_debug_dump_internals' =
is not an integer constant
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2423:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2423 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_dump_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2426:9: error: unknown =
type name 'u8'
 2426 |         u8      cluster_id;
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2427:9: error: unknown =
type name 'u8'
 2427 |         u8      cluster_specific_params[7];
      |         ^~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2428:9: error: unknown =
type name '__le32'
 2428 |         __le32  address_high;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2429:9: error: unknown =
type name '__le32'
 2429 |         __le32  address_low;
      |         ^~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:39: warning: =
division by zero [-Wdiv-by-zero]
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                       ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:308:41: note: in =
expansion of macro 'I40E_CHECK_STRUCT_LEN'
  308 | #define I40E_CHECK_CMD_LENGTH(X)        =
I40E_CHECK_STRUCT_LEN(16, X)
      |                                         ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:23: error: =
enumerator value for =
'i40e_static_assert_i40e_aqc_debug_modify_internals' is not an integer =
constant
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:303:56: note: in =
definition of macro 'I40E_CHECK_STRUCT_LEN'
  303 |         { i40e_static_assert_##X =3D (n)/((sizeof(struct X) =3D=3D=
 (n)) ? 1 : 0) }
      |                                                        ^
drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h:2432:1: note: in =
expansion of macro 'I40E_CHECK_CMD_LENGTH'
 2432 | I40E_CHECK_CMD_LENGTH(i40e_aqc_debug_modify_internals);
      | ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:20:9: error: unknown type =
name 'u32'
   20 |         u32 offset;     /* the base register */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:21:9: error: unknown type =
name 'u32'
   21 |         u32 mask;       /* bits that can be tested */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:22:9: error: unknown type =
name 'u32'
   22 |         u32 elements;   /* number of elements if array */
      |         ^~~
drivers/net/ethernet/intel/i40e/i40e_diag.h:23:9: error: unknown type =
name 'u32'
   23 |         u32 stride;     /* bytes between each element */
      |         ^~~
make[10]: *** [scripts/Makefile.build:243: =
drivers/net/ethernet/intel/i40e/i40e_diag.o] Error 1
make[10]: *** Waiting for unfinished jobs....
make[10]: *** [scripts/Makefile.build:243: =
drivers/net/ethernet/intel/i40e/i40e_ethtool.o] Error 1
make[9]: *** [scripts/Makefile.build:480: =
drivers/net/ethernet/intel/i40e] Error 2
make[8]: *** [scripts/Makefile.build:480: drivers/net/ethernet/intel] =
Error 2
make[7]: *** [scripts/Makefile.build:480: drivers/net/ethernet] Error 2
make[6]: *** [scripts/Makefile.build:480: drivers/net] Error 2
make[5]: *** [scripts/Makefile.build:480: drivers] Error 2
make[4]: *** [/build/linux-6.7.0/Makefile:1914: .] Error 2
make[3]: *** [Makefile:234: __sub-make] Error 2
make[3]: Leaving directory '/build/linux-6.7.0'
make[2]: *** [package/kernel26/kernel.mk:167: /build/linux-6.7.0/.built] =
Error 2
make[2]: Leaving directory '/build/'
make[1]: *** [Makefile:39: trg64] Error 2
make[1]: Leaving directory '/build/'
make: *** [Makefile:33: all] Error 2=

