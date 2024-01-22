Return-Path: <netdev+bounces-64917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBCB8377B6
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 00:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9ADB2868E2
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381AB4D13C;
	Mon, 22 Jan 2024 23:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="WsSivZpw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD95E4D136
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705965968; cv=none; b=HACxQiZHLcyccRYIAJGSgcVzkG0MfiYHF+oeH7aLOL9AW+wf0g1deeQpBdCpJS4LnosenryGQ2w9faWl+qRjxMY0XRp3UUbu+C084kQTuw0gbDy+Dl+1Vv/RL6bfAicyk+BtXi+D/UvR/jNcz2Be/UDMkAFmeoDNudNS7tIgvPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705965968; c=relaxed/simple;
	bh=zBsFULMhyKQVsv+XhVwTlozehwbpWiisI8Rnya718Kc=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=qttSKQP77fuGXh9TspB9dDKcgkUUkct9MvSC7Mc2Ndbo75G+AY3D8tTfdLRYJSR4wUfu1mOQDsZdTwMcExT4fC76j0LtaWAKaksIvJj2DKLVflobMKB2CFJvzTQHf+X0Peic9NBgRPRD3eOnWq8EG40DAmWdYH54Xrjf09qeqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=WsSivZpw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8C40F3F13F
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 23:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705965960;
	bh=7Ao3EAWZhvT7OJwXdGi+GNRQ3fv5HFlS+KJ3AbsDroU=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=WsSivZpwFTsZE/a06sqkvVGI/s9mxu5J9DcuSwioXloKD2NEzdks3hVtSLDIE2bIR
	 Ak8wBGlpOCyPQsa7HTqSQSNm/LxFx/ffVJjXoQ5/qmWotWBGjd1KbFH4DUc6AI7dAZ
	 sXr6APrnoC+nbZJPwl0guXT5RchQOzHEP0EtkympzsrMBROyvuimbSLyIvOHWnGz2r
	 30m1QTMKXohXR0MJiCGjTd2lFKKZqx6YKY58qYrkA08sVP0mn8OKiSc3ndw/VP+b4y
	 2AV77CBnRVZII9Gx/UTfCmSfCGNHh5t8trpIggyuALS0qX/ZWwdsoOAJSl6Gsptwbf
	 JwsVJpB9X5a8g==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d4a645af79so49113455ad.3
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 15:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705965959; x=1706570759;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Ao3EAWZhvT7OJwXdGi+GNRQ3fv5HFlS+KJ3AbsDroU=;
        b=PsgafixhL33iHBfNMid2aTZWLM6/VNF8syepjsIQxEklebADgSIUEll+RCdxa5OWxp
         rZULOCduKeC8s2zx5dOKauZdchaMcAfCnni5724iWF7ZOj6V5NjnMtS6Z+Nb0rjUP040
         fSRgLL9zzwpnz8WMuiN42otN4rSmsYOztl7gZqhP0xkU5wUo2RSNS+D6JNhD10o4ITou
         BY9FZKJYjVAWvvyNIRP8JTov5RMXnz1Ks6cBx/7em6aqJn9GfQDxlQuTQkY8O5T9n1Dw
         C0lDRb9qmXrxtlKNhdUgrgRWj4rWYyrkyes8epc5ZbeXFi1bduzlQ04a9scOKkzMlbDM
         TUFw==
X-Gm-Message-State: AOJu0Yx20C0ZtctaRlY4H4UvAgZ6o7tDYDphnk4VyRRARBmIxGbW/7hn
	cm4SqrFOLxfCTORcItt6trqlGMYiL0EY5Aa7UnCuskFWechKQ9QGg92IiJUhvw/J+xIAMNmUhzs
	ljQPQ0TtutBo1D6UeJ2nN1HssOfwFeHuspeup4BKeaIKxoTWpMp6JNN/rut7tJ/Vcqt1A+QvMPf
	nt7A==
X-Received: by 2002:a17:902:9303:b0:1d7:2947:4980 with SMTP id bc3-20020a170902930300b001d729474980mr4515079plb.122.1705965959126;
        Mon, 22 Jan 2024 15:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPn0pkxQGIsmf2zqgVJZmeBtU1/ybA8dW/67KIIsblUulatzkZU+xdTjggWqeWS9F1ufWtKg==
X-Received: by 2002:a17:902:9303:b0:1d7:2947:4980 with SMTP id bc3-20020a170902930300b001d729474980mr4515075plb.122.1705965958846;
        Mon, 22 Jan 2024 15:25:58 -0800 (PST)
Received: from famine.localdomain ([50.125.80.253])
        by smtp.gmail.com with ESMTPSA id ke11-20020a170903340b00b001d720323d54sm5891645plb.191.2024.01.22.15.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 15:25:58 -0800 (PST)
Received: by famine.localdomain (Postfix, from userid 1000)
	id F35A55FFF6; Mon, 22 Jan 2024 15:25:57 -0800 (PST)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id EC1239FB50;
	Mon, 22 Jan 2024 15:25:57 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Benjamin Poirier <bpoirier@nvidia.com>,
    Hangbin Liu <liuhangbin@gmail.com>,
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [TEST] bond_options.sh looks flaky
In-reply-to: <20240122135524.251b0975@kernel.org>
References: <20240122135524.251b0975@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Mon, 22 Jan 2024 13:55:24 -0800."
X-Mailer: MH-E 8.6+git; nmh 1.6; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17414.1705965957.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jan 2024 15:25:57 -0800
Message-ID: <17415.1705965957@famine>

Jakub Kicinski <kuba@kernel.org> wrote:

>Hi folks,
>
>looks like tools/testing/selftests/drivers/net/bonding/bond_options.sh
>is a bit flaky. This error:
>
># TEST: prio (balance-alb arp_ip_target primary_reselect 1)           [FA=
IL]
># Current active slave is eth2 but not eth1
>
>https://netdev-2.bots.linux.dev/vmksft-bonding/results/432442/7-bond-opti=
ons-sh
>
>was gone on the next run, even tho the only difference between =

>the content of the tree was:
>
>$ git diff net-next-2024-01-22--18-00..net-next-2024-01-22--21-00 --stat =

> Documentation/devicetree/bindings/net/adi,adin.yaml | 7 ++-----
> drivers/net/dsa/mv88e6xxx/chip.c                    | 2 +-
> drivers/net/phy/adin.c                              | 2 --
> 3 files changed, 3 insertions(+), 8 deletions(-)
>
>So definitely nothing of relevance.. =

>
>Any ideas?

	I think I see a couple of things in the test logic:

1) in bond_options.sh:

prio_arp()
{
	local primary_reselect
	local mode=3D$1

	for primary_reselect in 0 1 2; do
		prio_test "mode active-backup arp_interval 100 arp_ip_target ${g_ip4} pr=
imary eth1 primary_reselect $primary_reselect"
		log_test "prio" "$mode arp_ip_target primary_reselect $primary_reselect"
	done
}

	The above appears to always test with "mode active-backup"
regardless of what $mode contains, but logs that $mode was tested.  The
same is true for the prio_ns test that is just after prio_arp in
bond_options.sh.

2) The balance-alb and balance-tlb modes don't work with the ARP
monitor.  If the prio_arp or prio_ns tests were actually testing the
stated $mode with arp_interval, it should never succeed.

3) I'm not sure why this test fails, but the prior test that claims to
be active-backup does not, even though both appear to be actually
testing active-backup.  The log entries for the actual "prio
(active-backup arp_ip_target primary_reselect 1)" test start at time
281.913374, and differ from the failing test starting at 715.597039.

	-J
	=

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

