Return-Path: <netdev+bounces-229799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663CFBE0E46
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E472B19C6598
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 22:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F063016F5;
	Wed, 15 Oct 2025 22:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Gf5wz45Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED307262F
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760565764; cv=none; b=inz5WeKIheWFCaoEWbOJw7fribe+yA5jwhuGJfnsi75k/Ufi1yL5EieJ1SL5iu0i38ZSqd/dJgYi0dmajb3fh63r33KDwZHh7xXnEMgrwDFLnEJBHaFosVsCPQddmn1aHP5LPJp98zgmU1+7c5C4ZVMvF5wpSiUVFVUwt7+SnpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760565764; c=relaxed/simple;
	bh=/K3AFUK1IcU9Ry//EL9eWIshPL06i0vDN77GSYa92KU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XEa5uUMfvkprlHvsxzWL9q/IYW/l7tQI+49I52ccbdn9YYMmhy6ZYaOTukFbf+iZDIE0Wa9LBmqy30H0SKCE2MyVo7vwIPKAxO/+FOoF9Ydim6NWls90aTGyzHqBe7ulnESlS2MVXjF+Lq3dYj9c2WHIpffGJcWFZPgDCbkCuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Gf5wz45Y; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-781001e3846so100075b3a.2
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760565761; x=1761170561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JN4CWkUUC+xol10wiulNeLtn5DhTpmfhFyymGFUs7M=;
        b=Gf5wz45YRehPALQwc4l3LhhuaiJlpwHvlEBFYNs8ThVvkyUTkU4xp6Dqinuk2z6JfW
         kQ6f8ASs0PIzGwMbSFbqQFXBX4LXggszYQbncT01ydCZGfWHHITGgqQpa2V3TfAmpTQL
         oUWqkulZ3d+/lfdW9Ix5CRlltxAvm60H6BJ/MBOSo7uPNxJIzjCBhy0CCu9Nja3G8jPR
         P2JbrNgEUevXSttp2zmKqiI7W48pqurLx/hi6WYg8Vyh46SXg7K/bw3XwibkJIHfQC6S
         6MZINijIxzHXe+vVs/55COXAXtcm4SlSsXyoH3f6MeoXq1BraVFqWq05QeC455oa6r+X
         jY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760565761; x=1761170561;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JN4CWkUUC+xol10wiulNeLtn5DhTpmfhFyymGFUs7M=;
        b=mi2zLewB/XBagZ9ze2lcGdxfOGmwnh6ZI+moTsf5bnSC89NJlEj3huMG68yxAqd9SZ
         4zqDl48GvKOSuYyiNnTJ4e0bWmNR1dCFCN1ol2/nSmECbCjVo7ZX5z5eVbM+XuyRMrEZ
         MIP8x0w7tWrryykNQUBRnABEjl+9n4pA322PBI7JdA1TgoaWQz9LF1dOJ9zBjBHguXiT
         bUfS3UPTqhmHAX4Ab3ECvW/f2AoKw9XmxIVfdbLBcTpv+/ZU2jur2dXAL/tf8odU9OY6
         NYoje/WvFgOGldLlo4jPkiEf52I//t8nPJ67M38Q+Cr3Jd/VV06cfZA3YAgnVHrEtjfl
         sw1g==
X-Gm-Message-State: AOJu0Yz5PU6+YPzYL0c2vVq4ynreW12QcYjSyeV3wTmy0y/SY6CnM0kX
	lkDqOZDodTPZDbCh42bZ4oiqxmxQn+4fh910Ok7qj1FFlN4BQRHsN1tmCffXpgUcMxp5JZWNToI
	r28Fv4eE=
X-Gm-Gg: ASbGncsvF9gv0ygvogKqdHblK2WLbJ/wVHSgOcnPQXcyOuc2AFnYgJkmRThR1EhYfFR
	ok0Ivt7CSwCalqirl8YqdAbBehGhAx454X1/ygD3jCiiuPOcnKnpTzCwIqWn6rqYWxOl0FJyS9L
	qySueK6L6FY79eLZKJ2Ch+jMpbljJUDxzjq2oIZ/M4dJDyKn5NyRhfhgDLQnzCn48pPPoEKjB6/
	m/SE4nHMZ9OvsOFnQjt9exTSYcQ+lY2dkkTuoXSFAkpvBoN9W1fH+Ev/4bitD1xI1AFHwvkaPo7
	776HMZpf99bUFQOvQj+WHupFhb3T3KdufRDdhXj4sbAOyjC56UEU89fBBRm0kgKQ9x5S+YSkJ6+
	fruYqK8C3AbTMXjH1pi0iFsfvvBEftDuOzq35RPk1YpPm2ojJ0xB0C2VsgIF//s+9tdutZJppE5
	k+nnkSABXPo7zQajt06JnGWn369pCOA2iUhslurFJlksp+Z3Uc6T+n
X-Google-Smtp-Source: AGHT+IGvCys6FwOVsJlJ3xj26XEFov2nmhWbSNsLQcwumIN8VMNBMb90O7J7RcfQBblGmKaTQlrEug==
X-Received: by 2002:a05:6a21:99aa:b0:24e:9d94:7b17 with SMTP id adf61e73a8af0-32da80da6bemr34859806637.9.1760565761292;
        Wed, 15 Oct 2025 15:02:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33ba383dbe2sm681492a91.2.2025.10.15.15.02.40
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:02:41 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:02:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 220649] New: A bug is happening at
 __dev_change_net_namespace when runnning LXC/Incus service in 6.17
Message-ID: <20251015150238.6849de11@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Thu, 09 Oct 2025 13:08:57 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 220649] New: A bug is happening at __dev_change_net_namespace when runnning LXC/Incus service in 6.17


https://bugzilla.kernel.org/show_bug.cgi?id=220649

            Bug ID: 220649
           Summary: A bug is happening at __dev_change_net_namespace when
                    runnning LXC/Incus service in 6.17
           Product: Networking
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Other
          Assignee: stephen@networkplumber.org
          Reporter: kosmx.mc@gmail.com
        Regression: No

Created attachment 308780
  --> https://bugzilla.kernel.org/attachment.cgi?id=308780&action=edit  
Archive containing the dmesg slice with stack trace, and the git bisect log

Log from kernel dmesg is attached. 

Steps to Reproduce in a Libvirt/QEMU VM:
1) Install ArchLinux (all dependencies are available). I recommend using
archinstall, but anything can go
2) Install LXC/Incus (pacman -S incus)
3) configure incus for running: usermod -v 1000000-1000999999 -w
1000000-1000999999 root &&
incus admin init &&
incus launch images:debian/12 first
4) Previous step should trigger incus to do namespaces. I'm not sure what
syscall is causing the bug, so I do not have a mini C program. This should be
enough to see the log in the dmesg. (it can be done on any OS, VM is not
needed, but it was easier for me)


I also did a git bisect on the kernel, the first commit to have the bug is
0c17270f9b920e4e1777488f1911bbfdaf2af3be

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

