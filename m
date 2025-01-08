Return-Path: <netdev+bounces-156453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB00AA067AC
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 23:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F7FC1886AD6
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 22:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD92040B0;
	Wed,  8 Jan 2025 21:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9NbJdWl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC0E18A6A9
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736373596; cv=none; b=ocPO7WTohkLSjUfsh/b92kOeBPOKw6KVXybP/MdldYMZ2E4b5GtVYywpaQXpgJLX2zP8uOGyy7q8EPOeeOhzNSZLvB3zAEnUC7HdOuwCWALOW+yyyu0hrYNcX36GU4I9SoT/c6kbCsgnxn3FWy7bFPbaCInz9UaB3wUynTt8fIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736373596; c=relaxed/simple;
	bh=G6ULTlj/65TlbTR2+r+b6sBB2Q4ZUG2NaXECvuivGC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0h5dGKp0anLDF4QnPaJQc/UIV+Gz+OqFVAIzdcFw8TXh00WL4e6u6LRAoFcy2mnJnVmgGw9zR3oTJxAM7bAwBV4lhFos8sXFq888a1S3V5EXo/CILpSk7/EHCjIMJKE/04t+3t2tqq1mCRKrKzSt803Wy2vpycQ+/PLPRxOPdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t9NbJdWl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215740b7fb8so43585ad.0
        for <netdev@vger.kernel.org>; Wed, 08 Jan 2025 13:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736373593; x=1736978393; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1iLf1rWe8AwDYp3OI251+FCsND1Ellapftv0xf64nYQ=;
        b=t9NbJdWliBP/5R3goMf9fh+EhGTkS3Q/HTogSCu6cpwA1QxR/6iRtiOjCPin5ccNIY
         j+kHj2RyW7FbzOIgp36B9dZGd0KJYBtfnsx9s+OmA0E//pVd3iQ3ISYwkk4c9tGmptXw
         WmoXlJTH/B+z8k9l3vb0mGo84YL7EWuItFa161SliEzo/HRBzZfTndvbn3V0wHDbB2Ic
         ABWHa20H+J2wJiu+jtxe4tCeS47yFesyd7Z9kt74lykpmrCFz8xNwXPJkkNufhunnKYu
         0k2fuj+qXfnrjk08biTEz9/iGELEKOKM/9RR1kgNAzEvOIn1Xhi8ZnJY73Puz+n7H0vq
         VMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736373593; x=1736978393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iLf1rWe8AwDYp3OI251+FCsND1Ellapftv0xf64nYQ=;
        b=mK5MxhWPfJIiXnjbBLX90/MECq15X5PQ26NzkBRhoMCW84M+c5YCRy3BRCu883Zj+d
         3mbTs64bluloMaRek2t4gyf3BSHooAUpYHjTIxv4g76hHQdGoCyoXu2wQ/q8LuPV2BzK
         adrbqS/IX04/AxjaknfjAVxWzTBgbXSP6yJ+/f1vNRkwI2GNumT/p3dNMR7J0bwr7vsn
         6vWG5V1lMgrnqlK767Ou9bfcuofO7D17+FArInDTNdiQm/xndGvpAzcF8TxiZdsljuwO
         POkCQ7py5YHIa1OF0y9sS/LainazjdV+OprjxkZ4MbO+NKh87O6fICcNSaFchnvHrncZ
         qjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTSI3qKBHeRkc3F5mzqmyZwiQ1ZBx/DYad9tZWvsiuXKOSWktejDE8xIJ45TL2dMsrxwRV644=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1C3KPsPAYETgy3e2SQXDgLbxrArnntnU1oGQMZmOB58Ey0vOr
	wkr4jzB3gO6QQ2cRCMWqXic/qvjwbHiL74xfiaouYds19JfHu4ARxN7EJPMTuQ==
X-Gm-Gg: ASbGnctaXY5qenZXLil4s9Pjs7aS/BNuc6IWFX6XWQ3C6scGQa91wt1jjqPPhS5qz43
	TmyMRgAcmm9IwT3ME8r4fYeChmP/MTPMs8BckIBcBGTakk4Ejgop1Y70xWYF//CTZQTosKSuajc
	lPxXnShTHuGqQJ+APNUDSCASsRnQyLn4JszX06lgaNEJlLjABAvebemVfZ3p5in8MFMfnpG2Uh4
	pYGFDDEGdJQZulsr9D96LrfcziAKrxU9Pf7NHbnbuhRmG3HnS8fEHWZrzswP2h8mmsw74/gWkil
	5ewDghMyuIUhj7mTKdk=
X-Google-Smtp-Source: AGHT+IEiqfBGQ3dVy88LHEcmGYgx+u1E3hQ+kbFS0HeWFSnmdf/rZBZQtJsXTXJS/5KxcgrxRxDdyg==
X-Received: by 2002:a17:903:178f:b0:20c:f3cf:50e9 with SMTP id d9443c01a7336-21a8ea0ea61mr607705ad.4.1736373593411;
        Wed, 08 Jan 2025 13:59:53 -0800 (PST)
Received: from google.com (57.145.233.35.bc.googleusercontent.com. [35.233.145.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad2e4sm2090422a91.28.2025.01.08.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 13:59:52 -0800 (PST)
Date: Wed, 8 Jan 2025 21:59:49 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Li Li <dualli@chromium.org>
Cc: dualli@google.com, corbet@lwn.net, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	donald.hunter@gmail.com, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, maco@android.com,
	joel@joelfernandes.org, brauner@kernel.org, surenb@google.com,
	arnd@arndb.de, masahiroy@kernel.org, bagasdotme@gmail.com,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, netdev@vger.kernel.org,
	hridya@google.com, smoreland@google.com, kernel-team@android.com
Subject: Re: [PATCH v11 2/2] binder: report txn errors via generic netlink
Message-ID: <Z371VdHmZ3FVdrEI@google.com>
References: <20241218203740.4081865-1-dualli@chromium.org>
 <20241218203740.4081865-3-dualli@chromium.org>
 <Z32cpF4tkP5hUbgv@google.com>
 <Z32fhN6yq673YwmO@google.com>
 <CANBPYPi6O827JiJjEhL_QUztNXHSZA9iVSyzuXPNNgZdOzGk=Q@mail.gmail.com>
 <Z37NALuyABWOYJUj@google.com>
 <CANBPYPhEKuxZobTVTGj-BOpKEK+XXv-_C-BuekJDB2CerUn3LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBPYPhEKuxZobTVTGj-BOpKEK+XXv-_C-BuekJDB2CerUn3LA@mail.gmail.com>

On Wed, Jan 08, 2025 at 11:56:35AM -0800, Li Li wrote:
> This is a valid concern. Adding GENL_ADMIN_PERM should be enough to solve it.

Right! That seems to ask the genl stack to check for CAP_NET_ADMIN:

  if ((op.flags & GENL_ADMIN_PERM) &&
      !netlink_capable(skb, CAP_NET_ADMIN))
          return -EPERM;

... which is a much better option and we could drop the portid check to
validate permissions. Something like the following (untested)?

diff --git a/Documentation/netlink/specs/binder.yaml b/Documentation/netlink/specs/binder.yaml
index 23f26c83a7c9..a0ef31cba666 100644
--- a/Documentation/netlink/specs/binder.yaml
+++ b/Documentation/netlink/specs/binder.yaml
@@ -81,6 +81,7 @@ operations:
       name: report-setup
       doc: Set flags from user space.
       attribute-set: cmd
+      flags: [ admin-perm ]

       do:
         request: &params
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 536be42c531e..f6791f5f231a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6500,13 +6500,6 @@ int binder_nl_report_setup_doit(struct sk_buff *skb, struct genl_info *info)
 	pid = nla_get_u32(info->attrs[BINDER_A_CMD_PID]);
 	flags = nla_get_u32(info->attrs[BINDER_A_CMD_FLAGS]);

-	if (context->report_portid && context->report_portid != portid) {
-		NL_SET_ERR_MSG_FMT(info->extack,
-				   "No permission to set flags from %d",
-				   portid);
-		return -EPERM;
-	}
-
	if (!pid) {
		/* Set the global flags for the whole binder context */
		context->report_flags = flags;
diff --git a/drivers/android/binder_netlink.c b/drivers/android/binder_netlink.c
index ea008f4f3635..6b3d93ff7c5d 100644
--- a/drivers/android/binder_netlink.c
+++ b/drivers/android/binder_netlink.c
@@ -24,7 +24,7 @@ static const struct genl_split_ops binder_nl_ops[] = {
 		.doit		= binder_nl_report_setup_doit,
 		.policy		= binder_report_setup_nl_policy,
 		.maxattr	= BINDER_A_CMD_FLAGS,
-		.flags		= GENL_CMD_CAP_DO,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 };

