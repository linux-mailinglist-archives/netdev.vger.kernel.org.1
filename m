Return-Path: <netdev+bounces-240741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 95433C78DF5
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B757935D01B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19FF34C821;
	Fri, 21 Nov 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOKE6M3W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771B9332EC8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763725019; cv=none; b=Zn8D55IVARrNxogx1hHrH6VWAAtVxIevOGjhW1H4G8t48lIeIDuhIfki1PFUD6MghYq9PgPD+2F7EO9VcQw7H+SUhyHYFX8CtgvQz3hGXF9z0wR82/8dvzWY3plipapte1GyhWL0bndb01RZkFXSfHq1n+vzJr7MTU1xOV62e9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763725019; c=relaxed/simple;
	bh=LOYpujHQoJKoShOTqgQ9QJ9SHzwlbcEAO9ZGw/MItV8=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=PINEVnOh8k7YKJSdP0tSExtPHtVy0aYTzatKrCls9vQyQyqhGz2hbD5RpLzrExlG6sCqrzVm3/071RB4rACyRpdc99rXKUlBq/dX7hROHHU5Jm2zi/0i0g6+2O9ygoLtU/GfE9aU48hITNv+IjZeSenN3Ch2VtTcpUHqJ00JR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WOKE6M3W; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3c965cc4so1014742f8f.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763725013; x=1764329813; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CS8gyqFzkQ6r/Z2UVvHxbPt1ypXcs3FwemCtMOsmk8s=;
        b=WOKE6M3WUK5qGH1nUZNItVGAOnBqI48n/Zlz95GC7nUDWdm0gjVuAVt0Ef/mSk6AGS
         Ql+DZLVaN97BolVfxXna9T0lWeGeCpC5iDxEkufsI6hz7r2RzoqvzT1E0F4XNAbIzy0b
         9L6jG/Oarxp6KUQ75V2TUgOU7KegL4jfR6rcNhtn0owvMbyjSx35oU7MV9CefL4aZeNT
         5sH5MUSb3vGvGhmu6CZaBj3NfwqnasOFRKRPv1ebaVKJwEIQJF8EWDVFj0ihLCLnDhfg
         rJk9mAMJMPXlTIM8PeOJVGk31LnCSr60KCKuxGtKHpMyEJM6IJy07Z7P5yBsQN15gpWP
         0xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763725013; x=1764329813;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CS8gyqFzkQ6r/Z2UVvHxbPt1ypXcs3FwemCtMOsmk8s=;
        b=cmcnDLB5WAGkmuTk+tz81jUEKULHyCy+TZ2TiMTyYOnN+DfGvrQvdcQlj6XO9OfR9K
         i6fZqmisEoB9FqkV8qXBhi8gKhaq00dWKlsvzTOz2Dji/0L7s1nKB8n79S+/9a0QmSwZ
         vHhznI6wmhgTtL2rsckFtSI83iELRQPMzLvOTu8IZBPXD6rMmLRhWvjcTO3o4RcD9Bqd
         rBnO681snTkdwlHDofTA5V9Z5hxX/h9mdWOFrfL7AIINalnAWNSQf2+LGo0NCCG06gZ7
         E0tRp0INWBPrNU+5GWwV2qk6B2SIp80dXQQsTGuMlFlNSLg0d0Fl4Fr+SPR6H9wvzZwf
         DVLA==
X-Forwarded-Encrypted: i=1; AJvYcCWrdwpl6dsZoSP8ZKFHbQhrkXMTLzsQgfjJHQJETdu2dcZiCWkNW5wydB7Btw4DfBAiXo8kIhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcdJ3oVHoKq/nQP8MEQjCN9qkaqP2j3IAlC+9nI2jlweXLI9Ro
	8fVOlHgZ7pKyBeRCYD/ywpzX4hTC961gsXfIMq3wwTWbw2Az/MNMI8lc
X-Gm-Gg: ASbGncvk0d41snJP3UqCwHM3FB28XnbCNqHe7WprglOb9q1MWy9MR7n4O3nBMauIYf8
	isILxVKD8QYpWqy38Ek49CYXQAZR84hlCVcuLEXP+d+TyLesWztAjhB+nNexA+U7x4qd52c02Kw
	l5fu/y77PVkX1THatGzkJ4Uk338SW6M4KZDF2i+O4tKatMO28x/AwIpDBIBepvnYK7UXiAqSxhx
	0+xIQwZK9dRyiOS9Cq3WXtIF128dBp6m2e75Oi8nkcxkSUjOsQ2tLQXDiOR+czFnirToWzxb7Ue
	DznHqcOQYQoUo7hBSRFyhYOGO5Nvcbk+yvgBgwR1rrYVijtqfP3rhJngVsBNdIzoLzNQ8KplqQy
	rHkgCN9t4L2RRY7esizGU/nRbgxWOwiB7BcSwxFMpDlrEHNsCAAGvbaYTEsV5gyW2oLBztBx+B5
	QEe8djyBkV2leKS3WUM3pTi4U=
X-Google-Smtp-Source: AGHT+IEOAgZmPr6L2R2ZTzAQtOA1RU1DqXWvah0GGKJQuxKtItTZR/EwGeyivvDwMsUN+Ewo3KC8EQ==
X-Received: by 2002:a05:6000:4026:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-42cc125247bmr2705819f8f.0.1763725012584;
        Fri, 21 Nov 2025 03:36:52 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f819:b939:9ed6:5114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm10506268f8f.41.2025.11.21.03.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:36:52 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Jozsef Kadlecsik <kadlec@netfilter.org>,
  Florian Westphal <fw@strlen.de>,  Phil Sutter <phil@nwl.cc>,
  netfilter-devel@vger.kernel.org,  coreteam@netfilter.org
Subject: Re: [PATCH v5 2/6] doc/netlink: nftables: Add definitions
In-Reply-To: <20251120151754.1111675-3-one-d-wide@protonmail.com>
Date: Fri, 21 Nov 2025 11:33:06 +0000
Message-ID: <m2qztr4o3x.fsf@gmail.com>
References: <20251120151754.1111675-1-one-d-wide@protonmail.com>
	<20251120151754.1111675-3-one-d-wide@protonmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Remy D. Farley" <one-d-wide@protonmail.com> writes:

> New enums/flags:
> - payload-base
> - range-ops
> - registers
> - numgen-types
> - log-level
> - log-flags
>
> Added missing enumerations:
> - bitwise-ops
>
> Annotated with a doc comment:
> - bitwise-ops
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
> ---
>  Documentation/netlink/specs/nftables.yaml | 147 +++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
> index cce88819b..e0c25af1d 100644
> --- a/Documentation/netlink/specs/nftables.yaml
> +++ b/Documentation/netlink/specs/nftables.yaml
> @@ -66,9 +66,23 @@ definitions:
>      name: bitwise-ops
>      type: enum
>      entries:
> -      - bool
> -      - lshift
> -      - rshift
> +      -
> +        name: mask-xor  # aka bool (old name)
> +        doc: |
> +          mask-and-xor operation used to implement NOT, AND, OR and XOR
> +            dreg = (sreg & mask) ^ xor
> +          with these mask and xor values:
> +                    mask    xor
> +            NOT:    1       1
> +            OR:     ~x      x
> +            XOR:    1       x
> +            AND:    x       0

This does not render acceptably in the HTML docs and it deviates from
the way the text is presented in nf_tables.h - the description makes
sense in the context of the expression defined by expr-bitwise-attrs
which bitwise-ops is part of.

I suggest moving the doc to expr-bitwise-attrs, which has the advantage
that the ynl doc generator already handles preformatted text for attr
sets.

This diff should be sufficient; note the :: and block indentation:

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
index 136b2502a811..23106a68512f 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -68,15 +68,9 @@ definitions:
     entries:
       -
         name: mask-xor  # aka bool (old name)
-        doc: |
-          mask-and-xor operation used to implement NOT, AND, OR and XOR
-            dreg = (sreg & mask) ^ xor
-          with these mask and xor values:
-                    mask    xor
-            NOT:    1       1
-            OR:     ~x      x
-            XOR:    1       x
-            AND:    x       0
+        doc: >-
+          mask-and-xor operation used to implement NOT, AND, OR and XOR boolean
+          operations
       # Spinx docutils display warning when interleaving attrsets with strings
       - name: lshift
       - name: rshift
@@ -1014,6 +1008,22 @@ attribute-sets:
         nested-attributes: hook-dev-attrs
   -
     name: expr-bitwise-attrs
+    doc: |
+      The bitwise expression supports boolean and shift operations. It
+      implements the boolean operations by performing the following
+      operation::
+
+          dreg = (sreg & mask) ^ xor
+
+          with these mask and xor values:
+
+          op      mask    xor
+          ----    ----    ---
+          NOT:     1       1
+          OR:     ~x       x
+          XOR:     1       x
+          AND:     x       0
+
     attributes:
       -
         name: sreg

