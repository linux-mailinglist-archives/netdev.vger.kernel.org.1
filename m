Return-Path: <netdev+bounces-52158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEEA7FDA97
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 15:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63D82827CA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 14:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A135282;
	Wed, 29 Nov 2023 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="YZxqsLud"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FA6BE
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:57:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2860f7942b0so1313066a91.2
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701269855; x=1701874655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kXSeOFPgJ5Yf4vZ8pS4vm34bWmRtSnH5F/wZFrP0th8=;
        b=YZxqsLudXnjzzGp84639PdUlF5bt3f7I/8S9iNLDAQpQY9HZZZpYsCKqIYB1nWTsdz
         tpG/SLWXH5KYoecD7hYD3pNlHam4yWlWMkGagjqYr2qm2MLq9jbblUGPLJw9d5UCUGqZ
         HIe/NuU7pQkGuRglO1HPRaYXGHW5iDokGvvlzpPS2wAn4aImRwFbqGcUUib+0F6LjucX
         lVWQglte/TKGrZu17h9kTiAUrFgTSuaKXtBq2rQfmFPmJ73DPK4OegmiHdaX9Wd3yO7X
         3rHVtN5ayRY7i5BGtbiBvzAbASbSonBpjYr+cTgirVVZ7VuZvd/3Ehe1LtLFHorXpahg
         AAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269855; x=1701874655;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kXSeOFPgJ5Yf4vZ8pS4vm34bWmRtSnH5F/wZFrP0th8=;
        b=uT6JGNKlU/7DOO+Z2zxe+b6AYYn/DKpnl8QCfbxrfoyHzSYHtWkrygck+yiQRHu1yX
         wDTWg7/M+pvgkqw9TRIIPr/8c+gCyGdrxitNJ0WMFSjzsgo2R2us2q/jwe4FXqkOnEnW
         xyOFVGcfhFyoLhixO81MaJzZP7hrmAHoh+nE6+JoelYZXErEqjsP85lknsT08Qye36cn
         xTzx8WoI1jh6y9fQFFGOBAMDQgS6wXiY4aSKz+Q3nH1hjystN5iRkoEH40P5fWOYLNTH
         6ySxiakEKHZNwfy6tTPHMqOMlcbaU/vMUi4iFTSqxat805K4gpMIzPDMo6fc12v1TQaj
         Dlww==
X-Gm-Message-State: AOJu0Yw9UrCe/+hRpQNq+chm/4H1YkUh8Ae5kxo09j39ACcVkaifN+SQ
	AzjvbS6g+aYMe0zkhmXzGwOSeRy5qo38V2M4G3M=
X-Google-Smtp-Source: AGHT+IHTm/hXF6EDBnmUJcAJJ4XVcYcsDEDvJrneFCbT+h2gV1MUpUZj5ulB8mg4bABK/4wm//5NMg==
X-Received: by 2002:a17:90b:3b43:b0:285:940a:b9c0 with SMTP id ot3-20020a17090b3b4300b00285940ab9c0mr18013730pjb.35.1701269854978;
        Wed, 29 Nov 2023 06:57:34 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a035700b00283a0b0fd39sm1070313pjf.53.2023.11.29.06.57.34
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 06:57:34 -0800 (PST)
Date: Wed, 29 Nov 2023 06:57:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 218205] New: kernel 6.6.3 NULL pointer dereference send
 UDP
Message-ID: <20231129065733.6f14ac4f@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



Begin forwarded message:

Date: Wed, 29 Nov 2023 09:10:57 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 218205] New: kernel 6.6.3 NULL pointer dereference send UDP


https://bugzilla.kernel.org/show_bug.cgi?id=218205

            Bug ID: 218205
           Summary: kernel 6.6.3 NULL pointer dereference send UDP
           Product: Networking
           Version: 2.5
          Hardware: Intel
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: netolish@gmail.com
        Regression: No

Created attachment 305506
  --> https://bugzilla.kernel.org/attachment.cgi?id=305506&action=edit  
NULL pointer error log

In new 6.6.3 kernel on Gentoo during start chronyd kernel NULL pointer message
is show and after a while system hangs-up with kernel panic. 6.6.2 version
works fine.

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

