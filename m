Return-Path: <netdev+bounces-259328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIw6IO3llWneVwIAu9opvQ
	(envelope-from <netdev+bounces-259328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:16:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A22157A95
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 17:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 411383006143
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 16:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29995334682;
	Wed, 18 Feb 2026 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGQ59qt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82B2F1FED
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771431402; cv=pass; b=Wkf1GI43BpF9d55FcLn3gDT/2RSj7cww7JF/q4UR6Rq83xj/AY/nhu2P8P9SFdfvO5SvBpsiFOdz7hnNVK+xPadGkg9HxkxXBzpGo6JRa8YZIItyGXvVN+fVKdRpmlsmXHkRaBIWVn55XXtS3vspz5dJ9ufPFkl+cl2LIVMOmGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771431402; c=relaxed/simple;
	bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4J1unrP1TqL8csDz4N7TU9MBGuD4OLpGZxzAku0OWWL2eQF0HGiGCN3x4FDRhcmTsa+6x51yaKRYrIc7ev1jhCGlbvEQ+FW/BsXcTvC4EzEQhq6suZ9CVv+wPoYLFxRzgbJb+BI277eSyrcIlKMT2PPcAY65d9dK/4A4SpLfqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGQ59qt3; arc=pass smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-948bf40406bso2564241.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 08:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771431400; cv=none;
        d=google.com; s=arc-20240605;
        b=KJfiCTpi0dUtTWp4wKUx+VsHlMxRPiy3rDYDoNtZixilOEJz8AS1NuVZ8xTwnNqRFp
         VG4gtW+uXlJfbp08JoPSq3V2Yjj3hNG6SuNuAxaqV0i/NP2Ay4k4XUEb4pBCbAGXSELR
         nMbvqu7hfNUY9AiqXvD9OEJIHXvdNajKTbf8fbSHc5mvv+FQp+1rdnfrnQWqGNUtXM5n
         oB1VGzXxs52apPL9iw0AS1IXRsHrN5nU3XZmaktR6avI5yGYzlqIUa25QehNNZKMFdHt
         uSkr1cTMgzjopCBCbGCLJdKIN+ta5ztpxWgh8xrKkNf7KsP9R/P7JU1AXxDrHZvazOWg
         NfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        fh=OjLpSURgczad+6Bz7TonLW4HAIoyln0lWhAEOsetCGg=;
        b=Z+ak7ktPxZ9Of4H1noL3B3HCn2pn4ujEKgALS0LcqgZ32eUHGJsYO60obxy6PfLx16
         E4dKQ6rhKOSctsYUdogDc8QsUO4YWbMwfSw7jNO+s9dtaR0xf0S098UTaK3vt+4fRjvs
         1jlt7dprnzrop9LAj2Kt554IiE+eao+Qk+XyKElAlaCAW2UreeT8IDOqWXeKsfgYU23e
         XhLzN8m662BtX7Zp6hbbEDRksmIbQV7Yh5x8XNytODrrE6YMMTMMRjHrxXIUh/JoxkQx
         QFRSM+tttSK8oc17HN0QNKoHFBDSXkgc4kyWFDg6K+/6b70kmITV20lfq1blEOYbuuEH
         sTWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771431400; x=1772036200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        b=aGQ59qt3lxjvyW5qgAPBjzAhFrLxnsK0pjtDclfrXOH5rLnETDgSltMwNrRzoFYQw4
         girL7QFOhKBoZpA8/wy0GRDYU1vPshk1rxANkb/5d6oRe0q6oWJLxK1aoqQN7MEiduDg
         ke+DtyFHtOD7BUyVaa6aXnteqCuAWZsgADWjyW4hXJv2dTQ+NAD12SEM9rlZCWpPGOkZ
         0CjrRqKKbYt9OsfzjfQPBl7u778hsRx1+frTDWI8lDOBnr7kZx7TvDGBSJo8gp9FN3Q0
         y5EsaTzap7fLkyiW4PQWtZnTr/gjs5B1r/6U9aGwNR1MTSiUxVZ2KXeVzQpRSnAoy61w
         jEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771431400; x=1772036200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rb0aJpPuTZbiX/sAH/Mhd1I0HxysgNuewGPntopAVLs=;
        b=Fy1d5EsvklM3K5JwBziDZyEMRhnmt9dMST7nW4Q/hbt8ICoFdpa4BYQMvjCFqvXKV/
         cfdNNK5PXs1Cg4GsBMa3eSDbMeCV+zpLPHnfTSGW5qAIz4Oe16wo1zS2X9H/FSmmsdG9
         UD1MvhqxoXBal5iZKVj8zh5ShJp093mDQPzqCd9hQqfCFxt0YtmPMKzfLy+jMGZU6kvL
         DYtZOJsaFiZT3EgGvZl6BU+4mFL8MV92zIsmIMpriBXlP0idbmRSMVOzlog0rKuEJFfH
         i6Y194QKdgBZbC3/QHBT+TzlZGBT2UR2THcGSIIvWtQdqp9e+Kdeq6AsBqu4lg0x+CeO
         Ct8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcjesRSZlg881SBFD1xXNhTYSCzoxb7pLuZMfXtkX3RPjHSn8UkwLMj+vwCgKvgiMnn+PpPC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyvyVlPMbgbiSNadPKHzOPFz+YOPKaogMK3CohCvXLYFgku87L
	DchO2lOL6uQ190EOF5FtgxK+K99RslsKGa3OYuNXX1VUcMlkI0Sfxzf4818hrG1mureVtQUMnxN
	1YxjLKQyXH+tyP3W8EMpuAAkRVCD6h5I=
X-Gm-Gg: AZuq6aIMhzzTElBeUL0U9uE/OuOHuxHeDjClnKDI56PCyVLhoYM30Sti3xqyzAOcCKT
	5wtyYmTeFF/YrF2pAWi77D5E0BCaJu/qjdcwE4CAWGMfvzbsINUp0Arjx6GZWt8dAe+TUe1DeNw
	ZcgDZuUhzWtgFKT2uH7WJ5lQ7MqEKLdxiT/WBgpDx3AjLpGrG7ID11HNSxn4RJBmspbGTQmgR61
	rw/m//1JBJabomZY9UGTngur+tuQrBGxRtPMfc73IPfkT6kn0o7rPrOBFMM263stF7ybsi2Eokc
	0qnCRdxABBHWgiERevqqx/iJXKpav+UzQd4zGcjluZCr+vDrir86nt1EmoO6OQ==
X-Received: by 2002:a05:6102:942:b0:5f9:362a:8e61 with SMTP id
 ada2fe7eead31-5fe2b003fe5mr4897521137.39.1771431399417; Wed, 18 Feb 2026
 08:16:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bb4bf5fe648ac71c969c6228ac6e72ea85cbc64b.camel@gmail.com> <20260218104328.14341-1-slava.imameev@crowdstrike.com>
In-Reply-To: <20260218104328.14341-1-slava.imameev@crowdstrike.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 18 Feb 2026 11:16:27 -0500
X-Gm-Features: AaiRm53xQrJ6ikwNR6kkTu1MPp0M2xsnhx4ti2O0jpdoLOolu_Zzsh4x6LDX49E
Message-ID: <CAEXv5_jU_OvD8abO6YC-sCfcRpTt0xNAyb0zUy9Km-U8TTDdQg@mail.gmail.com>
Subject: Re: Re: [PATCH bpf-next v2 0/2] bpf: Add multi-level pointer parameter
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: eddyz87@gmail.com, andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	haoluo@google.com, horms@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-open-source@crowdstrike.com, martin.lau@linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259328-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,iogearbox.net,davemloft.net,google.com,crowdstrike.com,linux.dev,redhat.com,fomichev.me];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,kernsec.org:url]
X-Rspamd-Queue-Id: 01A22157A95
X-Rspamd-Action: no action

> I decided to address only multilevel pointers as this is what we
encountered in practice and have to use BPF helper workarounds.
I think there are no technical restrictions for treating single
level pointers as PTR_TO_MEM.

Hi Slava and Eduard,

If we add support for writable single-level int pointers, we could
trivially implement bpf_inode_set_xattr in the way that Alexei
originally suggested[1] when it was first attempted to be added.

One note, for this particular case, the kfunc would need to be able to
write to the xattr int* param, as lsm_get_xattr_slot[2] increments the
LSM-internal xattr_count. Others would be possible as well
(cred_getsecid).

[1] https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html
[2] https://elixir.bootlin.com/linux/v6.19-rc5/source/include/linux/lsm_hooks.h#L215

