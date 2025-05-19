Return-Path: <netdev+bounces-191677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17471ABCB29
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 00:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E974189EA36
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 22:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE7E21E08A;
	Mon, 19 May 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="eeoweJvt"
X-Original-To: netdev@vger.kernel.org
Received: from sonic303-22.consmr.mail.sg3.yahoo.com (sonic303-22.consmr.mail.sg3.yahoo.com [106.10.242.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E878521D587
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 22:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.242.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695339; cv=none; b=pO/jMG+wQ1x9rDcpc7tWiQ6Z4BxxJ7youyoM5wtqiy+622GsCEoQx126weZJgTAFZCJTjzOieaayT7j3965eNkz33VES+uVaiRu/MCuihTZS5tTW6/TExU7kcu5ieTrf9Rxmc3+tEyv4iMa+BNYYsL36u+PlxnBVWNLYqAOQRrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695339; c=relaxed/simple;
	bh=J5OAmadI3Puem8biWtWtI0iUk3W6kyLgtJaNGstnCGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nDkyIc2zPK4m/ttI969JJPSMkjiYp+ll5IsblIu5M6bBGQThphE9Fct9mkgI5F1h+OjxyDYDQAeo+glxDpTsJ57XgfAoyOVdyLuwigjhSd7e8J4PjObjXtQnXoN3CjkJDNexhqjQkO1cIjd7xUUO9d/a/LMJF7xFTtn9EoYVPQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=eeoweJvt; arc=none smtp.client-ip=106.10.242.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747695334; bh=GUM+9m8KJK4142bT4Ko5kH+9yddCEjxAngcqskahTgM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=eeoweJvttLxEFh0irAla7zIT8Zt6XuqXToJeehH2eTcpR/LF2RLSI+/1TpvwfzsCnp6PV9IJdwbZEV6goEMDHO6PLaMq1H6b0R2wTXXvyJtnesXwAbu1Vgj14d+Tp6AUeNPS1zk6dazystQbTAenAXV3LHK3nW/1G4ozYPcIyNsJmwFq4rbTB/ZDbA6gPcHCGwSo/pwmRga/wd4yrIxXJgrmolUsG/vmp+dY8iGgldr/S2f1awR+m9JB++O21eEzWgEIt09iYcuZhA6icoPrK2/2weBCuCIIeuN+uOBCmEB2tJjDaTRJAQkNJYhAttRYQ+t/ys6I4Q86Is+aIvQejw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1747695334; bh=vkU3TrbITIsnvBvIgKoCpvhTuD1IblysVpKxk725JVZ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=D79o4TvUMQLHb/PfuKXzs7JeCSIaLhYt6hHqB/1Ld6RhLkt7lC9QXg9CdS3RBSSPgNdPlfWp/+0QblzotCLSU6B7yjfIhViVon1KTOnWEAUbMYNhIrOjmD01iqUPPJa8HBnOa/jEz8M8N+ZzqdNiOphw51JRUYiQj+2vZJngNIlkASfMX/gGz4hehDxf4iLu+VVU5XIj8c8PYeIM0K6fp62O+CuTXkFkwBUzIFAY0VSqPHWOv7oaj6mHvxloW0glZSWbdHv4rg8jj+losA1PW7zlV4VwiGcayqlJLC1ZyNnbFuG3v44YXxNw0yI/nSiIEzfuCINSJndAvn4Minb45g==
X-YMail-OSG: KqI4p.sVM1mmRcJYKHQJFNlLK3K392_QbkTGmZiy_ICD4wSzN.PJIS7P2uE5fq7
 4c5xJvqcxvQcomBL.G9RL__fDM8pBep3eSFygRTHHvm8SqO9V63PI5Cak2DjohKPQfR7oBvEV3NV
 XsEumLrD9_mc_nw2kEqFtDagsDN9CIpG0gzLVB2W0z4bYwDn_LOhMCgtACeUEcEMOC1H3l3tmOLa
 ERBC6OggOEeor6Rip91h.xsfkh9hF5kSud.rOGPbK0ZjoH0J4Zdokvl27WDDHSyesZYno5mej4Gk
 AoikfpszHMl4d7KEryJoqHY0xjuSTE_Z.OSHnRdQs91m3Xvow5NWMc0kQxtsqKaeTZjPX6U9SiHC
 7R2qYL2_TS7UgKaRxJwH7IGPNdrfrcnvwYwxQRVqgzCzrIBix8qxmP8wETceG1sHxSJERv.4wP.w
 R1cebMK63QHQYle1fyc9P_B7ipeDnkg9ahwpJ2uK116SbasWdsK_j4aOwUzQqKSH_H6HeG4mEyeF
 1Ql_gnTSI8ReoiHw3xzHBUo6DkSNfZpPaHOmEAzhfIfsfpqpw8xhVMLbluj2efT3Pr_KXjeQTN7z
 TK6UHiM8yGqIf2S674fyCV6V5EMAUMguSc3ABmJbqhsWEhnPHoX6TiUJXJ3Ak0gJo8Z1PZFh0vWD
 bxUK_B917AdFY_qps.NhXeu_mjRdkowheJdkGhMeUu8t8zbzeDhfRr5cPoODBMh6cV9jbIB8oOws
 5pT3tZTG_oq8RKlraemCvZDBrPrY8geU5k04VsYTJXYf0Z2USO4Vcs.yk2exbvSpoaYLFiyPwUan
 GAHakAdNc.HAAyNUElLNyCQuseJMp0OrDZQ4aX0iu6ifpky30R0lR9QV.7il6oIDA1PH_zIx69pB
 2gResUOeRZdFmV_7.5xV9daBM3ByhFn9K.UZBmI2pvPwQSPKp0BtrqlOkwMern9Gqpau_VyUNuCl
 dvNZObvE00zK.Fe8UmMbkpy4Z6DkMD0ieO.cHArsPwGyfmKeDmNODuE6RaYFkR2Uz1njXkcjHSMB
 Yo_xH4EeomAvUN6LjtFMrDTZsFldqVwVyoctrsP_4XZ8gkbD8tOrJjkCFWxgoVJdC2UgOXY9TSHP
 .Pltl0cxilHxexdogx00USz7UJYDmyVhVEOZ2tQYxiad2YpKHRS1ifdZTCEbokWEGToelM_QOC41
 F7E8Kzl24ofpUylzLA.OQSTpgWvVGtQSdSm_HQCkuvvkzL7tO4e0LoF3MFdqH7horL74SofFuZPz
 Xib9gHXhgWF5Wf0gI6Eecy.xHuJp2Kya00gQwQ6CgfDW6bFiDYa.jE4PhnWQ2buJkBP0hYqouA3x
 Wm1v7JBWN3ncSJMWxa4fJEs_R3F84SEZYES8l9Rmh0CY8m6VALgYUxzMZDYKjXWFGMJAxpmSnbWm
 UBm.IhSVUJEsBDQf8TiMYUKnnkUw56jbiRsvaWtReRUu7ufPpt5xJzaJPN83jZKaDMt9lEayAfky
 0igcL7EkQzZELUuQe2Rhg1107F6SsIvj4B3EV7kmX7KegvSV62n3bL8sMUkxDK_kbohphP_2JsnY
 _k_m4aSGEYFU2octa6y9WmB8EQDD0ThDJWcRHbvM68MJzK_RjOXzMnK.eN.n_2h7wWMyUmwckS0d
 PQbsiqkRy5nuCjXlYf_LC78tDYqhl9QkyGAOi7PB0VnM9KXR8rxRkpKn0w._CIoImhnYF5v_VGo5
 txe58_RhYP8g93jWpqOvSBx8yKeSxJhYPZKHkv_mouZrBBLKjp7XqY5dxvJ1TeVgsl8ScxuITSTv
 S7qP0ySJPBzsM9WdBADfHW91MXPklWWwN4XA9achXbbHxcY9JPeNmm2iENSVEKUO7B5hGSLUooKz
 ZGfcTR392xCQPOv4k9I3CusgqpFc9jM9ujwvMdKsdw3YSNGrT74iLvreT.jVWLJ9R57LIYFJDIez
 seW_gCFYSNwKpXsaHBikvCKK.4o82cCWyeFyU2BEZ1vHUobRnLj57CJERah6yFxDC6worMllXPGh
 jOYR9Rz9nzwn7CgSAL8wKSdlkqSlEiJ250FteV6TEmHhRhjVPJ5xuq.xpj.OXn7.7WprVyIZ43xk
 71vEYmQzuulu2IXevTN4vQcUM5WMjeZsvnISrpT55fsQ73TdzRvG3UuPws2tXjTzTF7lXzww1VOW
 LKcOp4AB9jNtmNknFn0ktHR0jmtJDNz8PrzsO4D48gKmti94hCHlQgGiEuWtk_FJ325.DlaeC93E
 8GVY0H5rpyBEak1KloMiGNphVaGlZhSjuoXweuaYIc.EoRn8dXLqXPXr.vBbqTOp1zbBB6BG6EM5
 RhCyGYMlweihg.5uuMzbYUkBsOSb6OXVMsMhUqhhx
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 44275351-0cb6-44b4-ba66-f62eeb5caea5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.sg3.yahoo.com with HTTP; Mon, 19 May 2025 22:55:34 +0000
Received: by hermes--production-gq1-74d64bb7d7-grhph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 83c9dcc297e29fd8cf775d3838de304f;
          Mon, 19 May 2025 22:55:30 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: sumanth.gavini@yahoo.com
Cc: bongsu.jeon@samsung.com,
	broonie@kernel.org,
	cw00.choi@samsung.com,
	krzk@kernel.org,
	lee@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	myungjoo.ham@samsung.com,
	netdev@vger.kernel.org
Subject: WITHDRAWN - [PATCH v2 0/5] fix: Correct Samsung 'Electronics' spelling in copyright headers
Date: Mon, 19 May 2025 15:55:27 -0700
Message-ID: <20250519225527.148859-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519215452.138389-1-sumanth.gavini@yahoo.com>
References: <20250519215452.138389-1-sumanth.gavini@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the comment from the reviewer, This series will be replaced by individual subsystem patches. 
Link: https://lore.kernel.org/lkml/3aa30119-60e5-4dcb-b13a-1753966ca775@sirena.org.uk/#t

Regards,
Sumanth

