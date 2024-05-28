Return-Path: <netdev+bounces-98472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2985C8D189E
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 12:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8782283916
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 10:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE616132B;
	Tue, 28 May 2024 10:31:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8A3BB59
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 10:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892265; cv=none; b=YArnchNSKKK7+chz/O5nEYnieQS2evye34GtdjyE3pw80ihGA/aCsitLVYGkkn+4z89kv7zPIEtj216Qekd1QrMgXCGqH2la039zq1JrMYFHyqKPBf70Y4phV1L6A3/SpxT8rwyF0j7NIUR07w+Q3iOwmIIiqFtAtQ8k5kn0xmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892265; c=relaxed/simple;
	bh=HD72KymgkFuzWQb63KjNA8IH+pct7fnJxoMSm6yaP8E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HmshcRjgGSts1BBh8+4tHQc2Y53HOIFaJEpk997Uso9aAEQUrcy2rDBFiHmB1UhcqQJpvDsn0HM6KimWC3AjQPt73zbW1VF9de56JUt76g5pGPm1Zv10rttEZJb5RqBDstlHAOTmD+WeddtmatzPdTmdl2+bxj3s7d+6vULZTSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3737ee417baso5483195ab.1
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 03:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716892263; x=1717497063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bntl/gSvDphBAQnEJNXXaSDjJyEhEpRmpwDuqmdZhbo=;
        b=hCWZeurgsssXB4xenkbg1KMW3TF5H2lJaShbzLzOJ1HL6jmTIg4K/Ou3KxgK2YIcty
         1HChcgqR8U0zFVsuxn2IQLFTSFNCmztME2xGcPR+5a94FQuTCvwSuwBz/l/UYH1i1OqF
         gULxGD8kPtzEQmk/gPTi8rRiu25YKLyjbO5kFQ5rkGqfiyj53jI0J4KsWAEzKgUKQ7Qp
         2NwmAnF0u4RI7aagDhFEk+ykVBgo2nTf1nVqDuvGBbgzXw0sCn3KNjX74YFCkQzaM8Yn
         XX2zfF55A62fRpmwj8Cxwi5J+psU41TkevPYX2qkv/dpd3dg5fxNfZ2Vxc/MJlnVDlXz
         c+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0EBtvtNpeu+nQBdtEUgsVRzXrUZE5s5MsNkdNlnVVdHaffYN5Cxo0D1nGuem+F1nIJvSbeLl/ZlKlf7+cFNOHHGtb9ooA
X-Gm-Message-State: AOJu0YxddvF1ysPw6kTTqU8tbf46mUxAp+Hw2f9ZI6hTHyivF1WtIv2R
	i3RxonenaBzX/sjOUhPDjGPBX/U7t71pRMOywx11ctGDpSJAAl9Pc1uwi6ODIEk34/f4HQImJCP
	dA9ay+HQUKM8E/d5miWE+Pm9RGJLmW/awGSfXz3vY+OD51cFrEAv23rU=
X-Google-Smtp-Source: AGHT+IGQjxvfjJ/zU+SqpTStiVGSkCYxdqO+F1rCAe1GuRDOhKDRrjbDNObtWX97aLrYEKB955Y8Guhs2uUVn3Nn2MDkhbLkiBhG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d83:b0:36c:6080:753d with SMTP id
 e9e14a558f8ab-37347c2e5a9mr6260795ab.1.1716892263081; Tue, 28 May 2024
 03:31:03 -0700 (PDT)
Date: Tue, 28 May 2024 03:31:03 -0700
In-Reply-To: <ZlWpDZSqKRJaqLp9@localhost.localdomain>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075796406198121b1@google.com>
Subject: Re: [syzbot] [mm?] kernel BUG in __vma_reservation_common
From: syzbot <syzbot+d3fe2dc5ffe9380b714b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, netdev@vger.kernel.org, 
	osalvador@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://github.com/leberus/linux.git/hugetlb-vma_resv-enomem: failed to run ["git" "fetch" "--force" "ce94c574238e17bd72d74b088bd1c16ce6447814" "hugetlb-vma_resv-enomem"]: exit status 128
fatal: unable to connect to github.com:
github.com[0: 140.82.112.3]: errno=Connection timed out




Tested on:

commit:         [unknown 
git tree:       git://github.com/leberus/linux.git hugetlb-vma_resv-enomem
kernel config:  https://syzkaller.appspot.com/x/.config?x=48c05addbb27f3b0
dashboard link: https://syzkaller.appspot.com/bug?extid=d3fe2dc5ffe9380b714b
compiler:       

Note: no patches were applied.

