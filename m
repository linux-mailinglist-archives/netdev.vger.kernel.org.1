Return-Path: <netdev+bounces-283687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIhfKtXI92nQmAIAu9opvQ
	(envelope-from <netdev+bounces-283687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:14:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2544B7AAF
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9616F300564B
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E373ACEEB;
	Sun,  3 May 2026 22:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmaM2YET"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B001D3AD508
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777846481; cv=none; b=UbmaEVufAtpsRE0IV6qg6m/wujh/H0eZ5xa7aPNS22+bYJe/vGehad/fuSx61+24CDqGTJggg5KraTEKhb6WUbdPRPQ4qsvI2JVuWmdQiKWd2M2du2zgi1o5u4UPkrSQDbLdmY1KBfxtC8V3Ol9wkGEJZzpj7tPJDiy0Mb7cBIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777846481; c=relaxed/simple;
	bh=BaFK+l1sX3ADpfIjQNA2IUZt5l5N4nAXC9kCyMDguRA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Rki4Z9hxAo1VKZOHZOtln7YbD/IQ4/qD71/n+kKQW8npl7kISrZP/sZCUcOwly0PmHr+d6/lZQJMtVjGdh068Cwuo9TUjks7ZICjvii1hbRzlz429NZP73YV4iOFBsLrQXVgpKeF6lgLwuXVha1/pTRrB6X1NWb5duwn10oJ0IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmaM2YET; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-79a60975dc5so36672497b3.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777846479; x=1778451279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1s7lxifgy912ACtUOU9iNuu7fnofGoCw3ubhmVVhWxE=;
        b=XmaM2YET0AFJ1o1ITTvsLx/tHYs3R6DoQsJpc7pTJIS2vyEE2dhAf7fdKhv1n+lRze
         /h4ftr5/P2SmHXwlhX838V4sMnXCknpsmASodGqqiXcord/G0WCGwOJhdswdILocqDmb
         Z/G+6jL1squm05oRG9kPW0LOMW8FGzhHGatteBMhBXFgZSrnyd1xz8b+/ayoHexlw0Ni
         XnazVQcVKEw6EDICy2MujYux+/Unn/s2Nk/2h9oqLHh5bpMg6wh8R6q3XAFxrbuWhaEc
         Smvo2f7eahpk03ShRCcONJr+8/hFBYcRXg1eACiLjV4opaopcVAWFpmXz0OkyygyLXnK
         IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777846479; x=1778451279;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1s7lxifgy912ACtUOU9iNuu7fnofGoCw3ubhmVVhWxE=;
        b=r+H2eTlEGd/H7WrjBueCE2X5yIFQbc2blzKoYun0SxdxMoNOOQyiK0Fr8iC+AJJa0N
         qtR6UfkD6j40FCqe/mZ2TLdp9cdJ5cWh2tM1j229RHp8gbniz8OMMfH3PfWOcjKb/UxL
         u9kQipi/2J7kavYnFqytkhsoNlOLFcChpxBuThxF6uLSujBxO75wW464NI/bm5hftsup
         TlHtHxQXPt8RdRHjTkOOpg6A2JoUvD105aDRIJFSyUZFVzuT6fXhfAWc9A928CJp7EQj
         FUMBrZyhzFVzZhCalKwIeh/fkzOX6Z+yphOaDmJwjGG1eVXOab+sAVCrUe/LfTBmEtLb
         qDxw==
X-Gm-Message-State: AOJu0YzLCHV2aXlte9ZhjZiMYLbX6HN4h5MKsZm6aRYf68FU83z2+owg
	q+RxAOzuiZJbZ2FEbd6PtMZwXxmB+s9oDrzFtRagQmxkeghB0AxGDWQp
X-Gm-Gg: AeBDietZnMDjqP68oQbknjs96SYk7nUGbsMouHjV/n+MXzU3zaL12geiQPSsNGI3yXs
	B4ebKWxzkoYnSJYaQFqL6wPpAo1uteGAKb2a9cosgnCX9BWGgw0kNRrEP+Bolu3WWLkD3LC22tS
	Kf6ADUtEDw9hJl82YqSP2fjuro1I1UL447KymYYoR9AqUQ5FU3HddGl/rZnhmfS869PsPAHLa70
	xYLbuVN1OfJEg9v6Msa6xSLNUMCUFNfNuYWn73vK4gINfsgT6aEhaeGcmPwITfhUyxvXdqUAe2w
	9YJAM+EAi17zhjlxBhAIwjTVzdhR6SpUeLy/utC0O8Vx+pSwpXIBlEmrEp1RECftHrsrrcqry4l
	b5+S82HeNZW2KUchRZ15jgz3+x4HjRq11FCv9JWsjfkqbQk7LwJmjOCoepKeJHCE0aQhinsny0G
	oXukw1KAGpgn7NQhil5Z2VkzMBmqPxO+uzbrS9xGTFP8uBNf1Nzl/VwMgNazglThzUrQUG/L/nW
	3Qy0eD7nh3Aq1A=
X-Received: by 2002:a05:690c:92:b0:7a4:8718:8c73 with SMTP id 00721157ae682-7bd76f7591emr72539927b3.9.1777846478752;
        Sun, 03 May 2026 15:14:38 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66837e34sm40744557b3.28.2026.05.03.15.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 15:14:38 -0700 (PDT)
Date: Sun, 03 May 2026 18:14:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 shuah@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.258359727e7a2@gmail.com>
In-Reply-To: <20260501173918.575ecdc4@kernel.org>
References: <20260430132820.1944517-1-willemdebruijn.kernel@gmail.com>
 <20260430132820.1944517-2-willemdebruijn.kernel@gmail.com>
 <20260501173918.575ecdc4@kernel.org>
Subject: Re: [PATCH net-next v6 1/3] selftests: net: py: support cmd verifying
 expected failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1C2544B7AAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283687-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Jakub Kicinski wrote:
> On Thu, 30 Apr 2026 09:28:04 -0400 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > Support negative tests, where cmd raises an exception if the command
> > succeeded.
> > 
> > Existing fail values are
> > 
> > - True:            Pass if returncode == 0, raise Exception otherwise
> > - False:           Pass unconditionally
> > - None:            True iff not terminated explicitly
> > 
> > Introduce a variant of True that inverses the condition:
> > 
> > - 'verify_failed': Pass if returncode != 0, raise Exception otherwise
> > 
> > We cannot reuse False for this, because existing tests rely on current
> > behavior to pass unconditionally.
> > 
> > Only suppress regular test failure. Python subprocess may set a
> > negative return code on process crash or timeout. Those are not
> > anticipated failures.
> 
> The fact that subprocess sets retcode to negative on crash / timeout
> may be worth a comment in the code. I didn't know that.
> 
> > diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> > index 6c44a3d2bbf7..ef31c0ba47fc 100644
> > --- a/tools/testing/selftests/net/lib/py/utils.py
> > +++ b/tools/testing/selftests/net/lib/py/utils.py
> > @@ -111,10 +111,14 @@ class cmd:
> >  
> >          stdout, stderr = self._process_terminate(terminate=terminate,
> >                                                   timeout=timeout)
> > -        if self.proc.returncode != 0 and fail:
> > +
> > +        if (self.proc.returncode != 0 and fail and
> > +            (self.proc.returncode < 0 or fail != 'verify_failed')):
> 
> Personal preference but doesn't feel clean. I would have added 
> a dedicated argument for this. Up to you..

Do you mean adding an expect_fail as below? I have to thread it to cmd and bkg,
but it's not too bad.

@@ -112,13 +120,17 @@ class cmd:
         stdout, stderr = self._process_terminate(terminate=terminate,
                                                  timeout=timeout)

-        if (self.proc.returncode != 0 and fail and
-            (self.proc.returncode < 0 or fail != 'verify_failed')):
+        # Fail on unexpected test failure if fail.
+        # Fail on unexpected test success if expect_fail.
+        # Fail on negative returncode if either:
+        # Set by subprocess on crash or signal, this is never expected failure.
+        if (self.proc.returncode != 0 and fail or
+            (self.proc.returncode < 0 and expect_fail)):
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
             raise CmdExitFailure("Command failed", self)
-        elif self.proc.returncode == 0 and fail == 'verify_failed':
-            raise CmdExitFailure("Command succeeded while should fail", self)
+        elif self.proc.returncode == 0 and expect_fail:
+            raise CmdExitZeroFailure("Command succeeded (expected fail)", self)

 
> >              if len(stderr) > 0 and stderr[-1] == "\n":
> >                  stderr = stderr[:-1]
> >              raise CmdExitFailure("Command failed", self)
> > +        elif self.proc.returncode == 0 and fail == 'verify_failed':
> > +            raise CmdExitFailure("Command succeeded while should fail", self)
> 
> Can we create a new exception type? Just inherit CmdExitFailure 
> but name it more appropriately.
> 
> Regarding the message maybe: "Command succeeded (expected fail)" or
> "Command succeeded (unexpectedly)"



