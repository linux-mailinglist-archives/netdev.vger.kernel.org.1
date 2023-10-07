Return-Path: <netdev+bounces-38767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 444287BC64E
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 11:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711311C20956
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7661916439;
	Sat,  7 Oct 2023 09:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHkVyvgd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6814F84
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 09:02:09 +0000 (UTC)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C20B9;
	Sat,  7 Oct 2023 02:02:08 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ab9488f2f0so1227361241.3;
        Sat, 07 Oct 2023 02:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696669327; x=1697274127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9yumCYBwE15BAN27v3FA9ycLvlMlIx617zkJsKB3ec=;
        b=IHkVyvgdKmvSmC2dwA+TgUOo2Uyznw/yGtO58J6W2JsHJVGhQ7UVLxyI9JslZDIp+L
         jdlhjmWQOvcuyAWN7DvgzbylZ6uPtWSCvuZ3AIpSFgCgOFq9sZD0LoBcOsv+I8hzX0rR
         qsfdNl3aJUFJYHjgTFkXEkbQYf/pzoJG7zm4DIxXJQZdi6F3DVGU+6mTeWBaHkW43Xxf
         LTMrIGEVWQs9OmjkxVSM/4R1zMBtTkp+eHQxABD4UFAceQ9Jz/8vRNW/1Pnc65ISpMiQ
         NH36KTiwzLE5qkkJr7wNQdkgiXMN3cuFbjF9UJvzaV4yF/roV02F/A5Db0BXDNvutGSl
         G7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696669327; x=1697274127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9yumCYBwE15BAN27v3FA9ycLvlMlIx617zkJsKB3ec=;
        b=T28FP/2MzBCfrgydyN9b7vHsAjCo3e0y96JWAPjLV5lZfbDXZ9l10kRrinMdfZMok6
         yO6JigOGVUWazkYAoxl3bQqGSv5x/elza53y6dck8B0mW+eL/w0FwdJNTjTkTEhpSx3l
         ODgHF9ZpexPSpoqhIV3r7DmlLo+6SWCrWPrF6Cut9giabXIssp243XESyJLLUAhqmzdU
         8zqnqeMwajmim4gpS6HRChToL6j1BWq7+UArE712Mw9lPBnh7uq62WPmLcYA4aZEskhn
         p8xDkMALBm6XqC7VhqYL93LzWVDHa1jJ7dGXvtRLQ0Qd+CTeBifWjbIZSa6TjBCHtkrH
         T6Yw==
X-Gm-Message-State: AOJu0Yxb+ullWsVFCR73jlvsHnJqPZSwoT+VaqcBBix1t03j+fiC7XDK
	QI/cqROFdoPXkryYSKWRItGhSQpEYvmmAyB0tnw=
X-Google-Smtp-Source: AGHT+IEVhPnJJ1aOyZZvjxmaX8mXZyaFoAUnBiOn+DFshMgaCIYrNc5b7ECLC/u+EzTOHDW35nzx2CD/eWWS0QrN45s=
X-Received: by 2002:a1f:4f86:0:b0:49a:9146:ec02 with SMTP id
 d128-20020a1f4f86000000b0049a9146ec02mr9388884vkb.1.1696669327643; Sat, 07
 Oct 2023 02:02:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006224726.443836-1-ahmed.zaki@intel.com> <20231006224726.443836-2-ahmed.zaki@intel.com>
 <20231006172248.15c2e415@kernel.org>
In-Reply-To: <20231006172248.15c2e415@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Sat, 7 Oct 2023 04:01:30 -0500
Message-ID: <CAF=yD-Kp8-iQtDM3+mgfJ6Ba0vkAeb09VZBa_k6RUequEyjd0w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] net: ethtool: allow symmetric RSS hash
 for any flow type
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ahmed Zaki <ahmed.zaki@intel.com>, netdev@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org, corbet@lwn.net, 
	jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, vladimir.oltean@nxp.com, 
	andrew@lunn.ch, horms@kernel.org, mkubecek@suse.cz, 
	Wojciech Drewek <wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 7:22=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri,  6 Oct 2023 16:47:21 -0600 Ahmed Zaki wrote:
> > Symmetric RSS hash functions are beneficial in applications that monito=
r
> > both Tx and Rx packets of the same flow (IDS, software firewalls, ..etc=
).
> > Getting all traffic of the same flow on the same RX queue results in
> > higher CPU cache efficiency.
> >
> > Only fields that has counterparts in the other direction can be
> > accepted; IP src/dst and L4 src/dst ports.
> >
> > The user may request RSS hash symmetry for a specific flow type, via:
> >
> >     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n symmetric
> >
> > or turn symmetry off (asymmetric) by:
> >
> >     # ethtool -N|-U eth0 rx-flow-hash <flow_type> s|d|f|n
>
> Thanks for the changes, code looks good!
>
> The question left unanswered is whether we should care about the exact
> implementation of the symmetry (xor, xor duplicate, sort fields).
> Toeplitz-based RSS is very precisely specified, so we may want to carry
> that precision into the symmetric behavior. I have a weak preference
> to do so... but no willingness to argue with you, so let me put Willem
> on the spot and have him make a decision :)

I do have a stronger willingness to argue, thanks ;-)

Can we give a more precise name, such as symmetric-xor? In case
another device would implement another mode, such as the symmetric
toeplitz of __flow_hash_consistentify, it would be good to be able to
discern the modes.

