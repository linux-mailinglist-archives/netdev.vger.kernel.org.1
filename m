Return-Path: <netdev+bounces-175015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 252BBA626A5
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69BCC17F66F
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 05:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAC2190051;
	Sat, 15 Mar 2025 05:38:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4116EB42
	for <netdev@vger.kernel.org>; Sat, 15 Mar 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742017091; cv=none; b=FQbaNObaaD8UxsckC5DB10mJB1y5Y2mc14l+vCIyL1SvYLiPXuMLcoYUdJQKiqXfWORDxDbDCGwDl+pKDT0XnutMv4Ljg4yJiC5fl/TfSoA4P3/EAmc31Jz/ofykGHfBmkcGTpL4WVbbehmNJ6kjtKuFsfDG3XMe+SLhacdcUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742017091; c=relaxed/simple;
	bh=ZDiXjUknHETMzrlYn1zgWu+v7UPrqES23shmZOMFSYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LYki5Ch+u91AkFdkRt+9EVtfUY3n5/y9UwvQqO0x1qWWdvgstoNO2Lh4GFQRd+alNrXy+78/cKyFXOM3bovS4J49VAkN2OjnCZjrJpH/aIkr6T9xsd6810JjaMjRcK0s9h/SJ8WTCvMfFWPLTr6CPmpSRDfIgPtXYuHwvw3w2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ce81a40f5cso58094905ab.1
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 22:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742017088; x=1742621888;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jri1wgrpQV6ijagZsM9y5nNBdN2313llFI5vyTbWILA=;
        b=xIoCdppFeGE0h/Kgepk4NITfz7LUaOYmPBd9M41v7n2xGeEHQ/nUbavkJunV+VVSj4
         EhC2JMJT7r5SMI2NdhRNut7ZcsuOpjM5h4XBhvG3/WlECa7WWDpQK1TR4NZTjQId68zE
         30tZcis0b1BMnzt2+qSpfbJ7vinOyKvvAhv0FLzaGiKxv7lD3crZLiUclfQ3h8bvLE24
         eNP08OyyJ7awsIdpbJvlY1bNA/Y27MSmnQtDtO8LYQfmEco7h8aUXes3V/KypVWM8aVp
         2vM47upUu0JzZT+r29yimBnd7Kb6oU8CoUOqrutJmw1zKlrEj9t0oF/Vqguyj9Z9xf62
         Ft5A==
X-Forwarded-Encrypted: i=1; AJvYcCUN+dw3PCpyzyFA0Ba1iaN9oqG+UboENllg70sdzse59vftUV0vqKsmXHJOLNvH4NLDSy1m0Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpkhTr7EmYH9AS5JotTq0QbqeBwD9k1slwbchPCpSk7fQxDQso
	zdz2dwsPX7Bvodk7a7x1cJVpwSVKT5jGmnKdD5YXIeqEtRBcj4Hi4OYppxkqBiWQhmcEMOcWuty
	sONwAp8/xqIgbx20w49q1rG8N7yugFbUbHWtvS5bgOwCwJL4y2CXKdZU=
X-Google-Smtp-Source: AGHT+IFQ+XxRMp/jrAZMgPnZUJ5trjdXbQ0Y0KQeY63eEi4hA6eS3lbN90dOhbP8hV87Q1ta+3ekOz3dCXUnIFG3nJBSxi1Vh+6V
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3312:b0:3d4:3aba:e5ce with SMTP id
 e9e14a558f8ab-3d483a906ffmr53679835ab.20.1742017088726; Fri, 14 Mar 2025
 22:38:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 22:38:08 -0700
In-Reply-To: <20250315051051.1532-1-enjuk@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d51240.050a0220.14e108.0050.GAE@google.com>
Subject: Re: [syzbot] [bpf?] KASAN: slab-out-of-bounds Read in atomic_ptr_type_ok
From: syzbot <syzbot+a5964227adc0f904549c@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, enjuk@amazon.com, haoluo@google.com, 
	iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org, 
	kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yepeilin@google.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/bpf/verifier.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2d7597d6 selftests/bpf: Fix sockopt selftest failure o..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=a5964227adc0f904549c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ff2e54580000


