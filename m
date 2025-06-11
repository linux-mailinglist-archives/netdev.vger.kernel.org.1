Return-Path: <netdev+bounces-196663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3D5AD5C86
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5FC3A2183
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B52036F3;
	Wed, 11 Jun 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVjhFvTz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F851FF1D5;
	Wed, 11 Jun 2025 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660225; cv=none; b=nRfKr3cB7yJtAVzgHclvmDTurdXBrwprrnKcFwM+6D80uyrKqrmtGKMdGJoeIAMtRi+KMnw6mzNp2GnQWP+p5oSMCJcLw0c+qvz/FHmnE7sqFbUa6Tuc1h+kcG3ibGHrK7PvTJ0xgNV8UNpg/RXSjopN0Vm3ay7QXeCN0HX90OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660225; c=relaxed/simple;
	bh=Xjk6jlbvqJxFCXtvHLCcHfI2ncwIxhB0uF95GAVPX9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiQ4/IZiBf7ZX0gd0H6GNyjJjE7AWs59JPKJxaFfe3xQs4/ago4m9EKkBwp+KAVc6Tk56CS+tteoFODJe4sS4HfYa0kjjRoUiUDgOkH14JXTQ1AUomVDNEVVmfqySY3eiM57AvI0OKl5PIdZAr+/AFl53lH7a++R/9uicdy2rgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVjhFvTz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7426c44e014so105760b3a.3;
        Wed, 11 Jun 2025 09:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749660222; x=1750265022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I0KZjZcuxlm3KvqwjQhi1svjF1BUWgM7RrOG1tQndc=;
        b=cVjhFvTzQogpFMlmmXREXFT5Wg8BU/FcqMTehJ+RqtkVDCpV7P3+DFz2yLIpBH0uKQ
         kHOqMyyWgKnN2REM2Wq5LnFJ8wXYsKbd1T1/kSh1cs8W0AAO2cQ0Pj/Lu8VgqcUSKpqR
         Bcm1YeiCr06JVVR/jjxEewyjs8rwlNPpmHMcbdArZpDV+277AwILxytwMJg3qYsqawre
         08wHQZtvvXF8P9u7Uxt81J9uX4Tnjk2j99k4N43zgLhYeWxBxieFKjrW2ojDISYK06eP
         iOGlMFphsknOc7Z/27PI019lRWVLxOGWh7f3S/O8ZK1e8RxhhBcdSTkFjPzQYyYd4dW+
         i6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749660222; x=1750265022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I0KZjZcuxlm3KvqwjQhi1svjF1BUWgM7RrOG1tQndc=;
        b=Pbj9hQKBsoBIg3uBw4iiR9I2v8XU6YXViyqTvOCZ4SgIJyF9e8Fj6oFCFEuES5LOja
         z6HT7PtBpXeTcSKcXPHF0dNq3XvnkilooA8CM+G8n18f09xAOxTZXkE/MfQr/Ft5XOCJ
         ygE0yPYVTGlrIJpJwKh7Y2/nwvoE44CbPBrZUsDUGsfUoO8szEDSdNsp/uBNJ3fAp+3d
         aKIec/cYVDx4xNaIV5FPDpBIVjvlBekFnkzJ80RpRO1796vzip23Vq86IwNKix+qQ3dw
         wm6i7bLJx5I3mKbHsopdVhmSnL0qKJNhtfW2bW8fxrMeuePcamX6AdMm65Epk8ScAU46
         mzdA==
X-Forwarded-Encrypted: i=1; AJvYcCW3468zvrgQelsnaeZpkmiGssdfHCxsTSgjJSbiV1lquN3tks/i1GIPZpr+nQZqf6UMa8+MGCtscJbDZhA=@vger.kernel.org, AJvYcCW6B6i+Eta6W6ZzAvZtmLzhcJV7qYdjbZUFN/uH8pt6t8BiwHWKJ3cVQCV28GEL7HeYK8PBuXJm@vger.kernel.org
X-Gm-Message-State: AOJu0YzDOF7vgEuIkvJ87JMB3RA/+tU0WiFzu5JvaJF2B7xaU31gIDrp
	dirSpurdbP5oIaSJ9FmN8u38Q/8YlTKJsCFLVcC+bF9OVR1/t1IFUIQ=
X-Gm-Gg: ASbGncvlapYpt4X319apoinfMctJa3D2Lijh8TPIGtQbrIqFgEcJFh4qXpeHnzw1VJA
	NIRxx7bHKVl3bNNwfW9RmQlrj+HX+WukFs9X+SeZHqsWRzUnGCTutZ84sAlci4z9Xu9i3kaqVAv
	4v1zWXx9eSIAK9xPHHgSoJgm+gc7m7Dn9Fevf8gujjnYJHDB86Bn1QQ0f7YJCJE72YhnRyDP26e
	5H7bnf87WFszmkC6Qb8VC5DEvhTkHSiDbqYaOAvkic7xHbKcUvXrhUpcPD+53YwBtzxqO6oRUxO
	52li/dQj5VLFyQ2DhEFFBHRhzNRTHeGvCC6892U=
X-Google-Smtp-Source: AGHT+IHK1hZHCZkZXsnAgHk1raXAb/+BFYH1b8S96weug7GKHBU9JBTLLWV5Ri0WxGqA+7TLEBKnow==
X-Received: by 2002:a05:6a00:2d03:b0:736:5753:12f7 with SMTP id d2e1a72fcca58-7486cb44b36mr5627782b3a.3.1749660222115;
        Wed, 11 Jun 2025 09:43:42 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c8a6bsm9702847b3a.142.2025.06.11.09.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:43:41 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: christian@heusel.eu
Cc: davem@davemloft.net,
	difrost.kernel@gmail.com,
	dnaim@cachyos.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
Date: Wed, 11 Jun 2025 09:42:20 -0700
Message-ID: <20250611164339.2828069-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Heusel <christian@heusel.eu>
Date: Wed, 11 Jun 2025 13:46:01 +0200
> On 25/06/10 09:22PM, Jacek Łuczak wrote:
> > Hi,
> 
> Hey,
> 
> > Bisection points to:
> > [3f84d577b79d2fce8221244f2509734940609ca6] af_unix: Inherit sk_flags
> > at connect().
> 
> I'm also suffering from an issue that I have bisected to the same commit,
> although in a totally different environment and with other reproduction
> steps: For me the Xorg server crashes as soon as I re-plug my laptops
> power chord and afterwards I can only switch to a TTY to debug. No
> errors are logged in the dmesg.
> 
> This is the relevant excerpt from the Xorg log (full one is attached):
> 
> [    36.544] (EE) modeset(0): Failed to set CTM property: -13
> [    36.544] (EE) modeset(0): Failed to set CTM property: -13
> [    36.544] (II) modeset(0): EDID vendor "LEN", prod id 16553
> [    36.544] (II) modeset(0): Printing DDC gathered Modelines:
> [    36.544] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
> [    36.547] (EE) modeset(0): Failed to set CTM property: -13
> [    36.547] (EE) modeset(0): Failed to set CTM property: -13
> [    36.547] (II) modeset(0): EDID vendor "LEN", prod id 16553
> [    36.547] (II) modeset(0): Printing DDC gathered Modelines:
> [    36.547] (II) modeset(0): Modeline "1920x1080"x0.0  138.78  1920 1968 2000 2080  1080 1090 1096 1112 -hsync -vsync (66.7 kHz eP)
> [    36.897] (WW) modeset(0): Present-unflip: queue flip during flip on CRTC 0 failed: Permission denied
> [    37.196] (EE) modeset(0): Failed to set CTM property: -13
> [    37.196] (EE) modeset(0): failed to set mode: No such file or directory
> 
> 
> I can also confirm that reverting the patch on top of 6.16-rc1 fixes the
> issue for me (thanks for coming up with the revert to Naim from the
> CachyOS team!).
> 
> My xorg version is 21.1.16-1 on Arch Linux and I have attached the
> revert, my xorg log from the crash and bisection log to this mail!
> 
> I'll also CC a few of the netdev people that might have further insights
> for this issue!
> 
> > Reverting entire SO_PASSRIGHTS fixes the issue.

Thanks for the report.

Could you test the diff below ?

look like some programs start listen()ing before setting
SO_PASSCRED or SO_PASSPIDFD and there's a small race window.

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index fd6b5e17f6c4..87439d7f965d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
 	if (UNIXCB(skb).pid)
 		return;
 
-	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
+	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
+	    !other->sk_socket) {
 		UNIXCB(skb).pid = get_pid(task_tgid(current));
 		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
 	}
---8<---

