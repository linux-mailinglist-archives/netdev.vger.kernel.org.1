Return-Path: <netdev+bounces-240910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101AC7BFEB
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 01:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F9A734EA18
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 00:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F43594A;
	Sat, 22 Nov 2025 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dF3EBsnL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041318E20
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770212; cv=none; b=CeGrykXneIv5osRSN3MwZLZ5Bnf8pdOB4L1gi3XjaQrsMseEwWR4J2k2s4zXP4ZS+oGmDF1bZ6JuN5WDGh4KhMELy+roQYVWdjX+uEosbUmUeZLnvKJiyLXR2bZPV3LiwRIGdEPBCug5Ng07cmtwmgB8ShGjfvoD1QeTR29FCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770212; c=relaxed/simple;
	bh=rvhN+UrIpp5KBh/jS9D/Vga20XhGPMaE2GB7C8/fL4s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r4i/424m7hJomMksaDb1AG9E1DKO+EZ6Eys8Zrg53neKnC94XOMTD+cP9M5swEC/MGGtgthNQe/nQsfv08vXkTHvNIAaWULfVjtP/olLeiPXT9GiRbQp7S9Gd0YKpXycjV7MsK8Oc8KuH8AF3gTNZ0exn+fTaHXEI3zujqWOxEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=dF3EBsnL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-343ee44d89aso3946286a91.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763770210; x=1764375010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/Qn5J8WAi+Jn6RgdNF6erSiLxDQRcmUkmlYRm66bKs=;
        b=dF3EBsnLMkz0JHqYdWlsbTf/FeSyKLV2OARjHIhOsEkwSYvPlatHrLc+Iiqn7Z3zIp
         O/XRYadXOtu2nBOlJZIBq7jVUg5aX9BGIScvJalI6d5k3ayDuhTwbNKR8+PWSF6332bM
         yKQxg4lMk8bCzwXvDp2rOc6vI0A1fulTCZqIFRJZWYGFDE/UOBNcyEqJI7H8El2RAfkE
         RJzf2pEOBy8oWFB75S92gIzO0usVn3M8ripylphRayMl/u4c7irEwzc1YMcSl0QZEbOx
         y+MIDlr1BhX2RPXUwt+lKkse/i7QvkebuNG0/YWaeyJwmwPpEtrMxkkxaQe2Fd0xxE75
         ifig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763770210; x=1764375010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/Qn5J8WAi+Jn6RgdNF6erSiLxDQRcmUkmlYRm66bKs=;
        b=Rrw3xP9pkmZvPk+avQoDK/kRczJY5YmtFw8y85hdxxPXF38nEikE8njqi7pfhyySV4
         5UZgg5Iqu6mqGA7dIvyCquw9mpSXb0Mrt8Bi7fsAZ/K7zvOjnTO3MoAZs7wpKYyFPdNg
         4UraKh5lsKZ2APVLn2rR/w/sMjuRVbTn9xtYyXyCWC1A7ZI0Nh/Vn/G5sWIyichKI2Bo
         roxegZxOmr7QwiNpN7xMIwAnpQ0bkHyv8B7x4gWxG66KYNNXHBh9ABp0VVjArleGm+Xc
         XJ0TUyIBmzCUsKauuMIzFIqCulgspz9M7Jx89FlUnM//T59TtZdMb3g81xHZ7eufmnHG
         eMwQ==
X-Gm-Message-State: AOJu0YxX2XBQxME6ajbyvPRoYAPDW8wnD5P8n3iyvs9Sc5WhmGiYKlT1
	XIgS+foddNvo9Rnm623CcteYx2PCcT6HgCdOXye4pbcs0xUxKDGPLFtqSoEV4vqP/7fuTEYkO4H
	UKDto
X-Gm-Gg: ASbGncsLfh/V5727zTg0dBm6K4oFERb23KnfBtg5Lb4vdnQLRYz0bb85lMVYQDH92eM
	CGDiqxak1Vb6oCSjSa3aksBAmyP8BDdb8GUtJK2l9TOa4iolUnZd0tZ9UVTq7Yobj22brJS3jle
	Et51DmjBSchTC46EK2EQqcVfpV9LCpSKqBmJBD7PfhYBX7maRi+XVDFQ+AONKh0tvxq1GA+x2Xi
	WSQ1CCin0aXTFOCPbEvzTA1i2RKP7wLOBF92hfxMjoamIvumvuIEXoBjUBQfjsscTxWFHOyJnB0
	J8YV5FouKk9EwAWwtIBFsi12az7RJR9VYiBFNRiMwWx+ErlTIrgBUgiR61iyiAgoh72xaoFlxtJ
	MnsfABzGBIsDHa56G2qn8q4nnVZ65LjwaCd0r9KN6yeHSQZUWEUb7xbKKql09iXtenXEXm7quXe
	zHmC14AG+DpSqALbW2NvnKn19Ax16PPwnWjxD9Ndd7zeu1wI+f9CC2
X-Google-Smtp-Source: AGHT+IErdoGIRXA75bRJhgS2+dN0uCNsySrQcClC67jXs5Lj8Ow1hFEWyJN1I7U1lil3enMhzT2kqA==
X-Received: by 2002:a17:90b:2f44:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34733e60958mr5055120a91.12.1763770209741;
        Fri, 21 Nov 2025 16:10:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345b01d934csm7302304a91.1.2025.11.21.16.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 16:10:09 -0800 (PST)
Date: Fri, 21 Nov 2025 16:10:07 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhengyi Fu <i@fuzy.me>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] iproute2 - ip -d -j tuntap outputs malformed JSON
Message-ID: <20251121161007.4c7ebae6@phoenix.local>
In-Reply-To: <87jyzkvwoq.fsf@fuzy.me>
References: <87jyzkvwoq.fsf@fuzy.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 12:25:41 +0800
Zhengyi Fu <i@fuzy.me> wrote:

> Hi iproute2 maintainers,
>=20
>     $ sudo ip -d -j tuntap
>     [{"ifname":"tun0","flags":["tun","persist"],"processes":["name":"ssh"=
,"pid":86812]}]
>=20
> The =E2=80=9Cprocesses=E2=80=9D value looks like it should be an array of=
 objects, so
> the inner braces seem to be missing:
>=20
>     [{"ifname":"tun0","flags":["tun","persist"],"processes":[{"name":"ssh=
","pid":86812}]}]
>=20
> Could you confirm whether this is a formatting bug or if the output is
> intentionally flattened?
>=20
> Thanks!
>=20

It should be an array of objects. You can confirm by seeing the output
with multiple processes.

Does this fix it?

diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index b7018a6f..6718ec6c 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -314,6 +314,7 @@ static void show_processes(const char *name)
                                   !strcmp(name, value)) {
                                SPRINT_BUF(pname);
=20
+                               open_json_object(NULL);
                                if (get_task_name(pid, pname, sizeof(pname)=
))
                                        print_string(PRINT_ANY, "name",
                                                     "%s", "<NULL>");
@@ -322,6 +323,7 @@ static void show_processes(const char *name)
                                                     "%s", pname);
=20
                                print_uint(PRINT_ANY, "pid", "(%d)", pid);
+                               close_json_object();
                        }
=20
                        free(key);

