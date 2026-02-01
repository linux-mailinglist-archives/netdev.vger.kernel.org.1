Return-Path: <netdev+bounces-255804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBqKNKZxgGkw8QIAu9opvQ
	(envelope-from <netdev+bounces-255804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:43:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FBECA373
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 10:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEC0230055BC
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 09:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552A421B918;
	Mon,  2 Feb 2026 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnPljb22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEB4A21
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025379; cv=none; b=Lc+8AGeZZ8CQOkzeaPDab/UIBeKIo4JvFLqfXqHOjDQoUDN7wQrufxLVpD1IxzM/WMljabtblxbMOw5lLrt6Uf1L+ujVBARtwgXcEEV04ZCkxvaaTIm23xtnRS4ToTh331SpdaEF4V+D5fFnumREOI1TSj6dPT2+DRss5My54u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025379; c=relaxed/simple;
	bh=Q+q0MnRJ7TafsdlNfqWfKMyIY1f2MwoOYmnDe/q7quY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=dRN50SsWuZT9Z1b7GEQLSHVOBS8ocYLXi0/Hou0aP/3xQ7vhRcGjF4QHCfDf72bQLp1iWk/i/F6Oc3SvII/J4sv5Hl9xsaqHN91E4XhOj3/RpmxOE4jF3SLhwQyR0OW8GVy+OoQXsWeZ5Hz25DoWziosnNdmS3teg6/5tfKnDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnPljb22; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47ee0291921so39165115e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770025376; x=1770630176; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Z5amyKxXGiqlzxm+GafS9ZCIVO0TTmiXSHRvaC4Bu4=;
        b=PnPljb22xk/J7ak9Ch2enkueDL6CoFpTjTiJOAcqJs2ZLYK9OT3oP4i7hGQrmdbeev
         ShLby3XXm/BUt9ud3OzHZG0by+8Ps3qsZ1eTMGH8swDEYum6DVSp6BBATB/T6f/ORMhu
         aBpsvZSkwqNICB+lYeI1m1sVk73Nc29q4LLgSFqxbo7HiTKj9ZTa8AI7U8rdKmc7s1dw
         JOh9Dnj7Xm/lXzZIXBlln4VoMxZH/XM7ADtEpjgS+NQb0C9gYnpeR5P0Mv6+RAxgSzUX
         zNmd5iTge0Kk+AicKgMKuQFnsE2lsuQjP3s2eaOYya/YwWt8VTSVlFdumIMBKipdyzTh
         UWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770025376; x=1770630176;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Z5amyKxXGiqlzxm+GafS9ZCIVO0TTmiXSHRvaC4Bu4=;
        b=rzBHLfuURKr+ZYA46Qlu/Wu0RmLGRgS4WPFw5UD13j/jtywMEbSGlg/fm3BSHdVKAQ
         vnLo5uVz09de33t3TDbbeSUZX/KYttNIJtlPyjPqijwExvo1h7MSHBjFwZPPuU+67Tef
         osTt8AaI1QtoPwpzGw7w8wMs6MQYBKjEFtBiwxaw2tat2wAjqZgNYzVdGM3AqAl7MMI2
         Bgikh/y3jhTA6aT46mfhOQXj2BdOORsAyvGXdsOb8mVbARvdeVadvKm1+GkqpeRk2zTJ
         vf/nD7iuPq2GaGwKW6qBbxxqAKgmrCq8u+9cPaMe+mUNy6jZga4sMs1Liytc+tsIIrfO
         Q1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWATf+ggZdJPjF0Cev1t+/o5LAShK/rTaSSLfwu6JgwYbPAILxr4NOLazgOnt3/iz3yBbxTKEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wDV855eyEHO9e2zsrVCoB1VqyyrVxMaIQH16K3EiSq6GXo1Y
	GbVSeDjEMr8xItblJuGvbROCd1h8YezucQ/fnT9aMsATpbPoXqcELJRn
X-Gm-Gg: AZuq6aIvnmU6KCm9bzhkSQwSM1TNb+hnXx+3EgxhDNpHNwQOHTFxdkAgsDZ4A1JJz6a
	IZVhRjs4Kf7J+jOv5GiZ+PDlE3qib2AsrAvd/e35fExUVUeet0UfLhsHVkWWRITTkyQBd3DLE2I
	KJUg3B5Hs+W9Eeomp7qh6qsTFwxP9DYzdCOso+i1+rmteolTihJiTepWtawAFNEtPpmfa/JTcQs
	qqGFbvh1ofAcQ46y/XkKqRIRDcbiBBUYKz7J0YDrbByWXo25KTKTmYkgtlI7Z74QXrNEqWGSnx1
	CvZcr9N/3rbvTTvMhiBEd1r1NfDUkche0iW6MHtK+eQz1I8gFssIDp3sTNnTFXb6ivs49a+GSPz
	x1g4T/58ReP3UlzuUfSLi0YdwWFGi0RSinkFmsMYoe0Liw1+sG6Lp/C0WSn/HzTGJVTH0UxxJcV
	s+L8AI28yb35CBGXnFxQcujw4=
X-Received: by 2002:a05:600c:4e0b:b0:480:6dff:e786 with SMTP id 5b1f17b1804b1-482db4f6f67mr126473535e9.37.1770025375957;
        Mon, 02 Feb 2026 01:42:55 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:40a4:df72:97a6:2c17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806cdeafffsm361039245e9.7.2026.02.02.01.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 01:42:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  sdf@fomichev.me,  gal@nvidia.com
Subject: Re: [PATCH net-next] tools: ynl: cli: make the output compact
In-Reply-To: <20260131203029.1173492-1-kuba@kernel.org>
Date: Sun, 01 Feb 2026 17:06:00 +0000
Message-ID: <m2sebk9yx3.fsf@gmail.com>
References: <20260131203029.1173492-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255804-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79FBECA373
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> Make the default (non-JSON) output more compact. Looking at RSS
> context dumps is pretty much impossible without this, because
> default print shows the indirection table with line per entry:
>
>   'indir': [0,
>             1,
>             2,
> 	    ...
>
> And indirection tables have 100-200 entries each.
>
> The compact output is far more readable:
>
>     'indir': [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
>               16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

