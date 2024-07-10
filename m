Return-Path: <netdev+bounces-110694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2D92DC59
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 01:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DE51F26099
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7E414D6E1;
	Wed, 10 Jul 2024 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aoX/waoN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C9114D290
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720652869; cv=none; b=kUJT9Hv2N3VcYIMNiPwGIcuw80d0pfWuPtN/d5pCHw396ATtbuOtqwJNA4RHXaiI3F/KOLCOFTHux2s4ef3Vm0V8qpNgvh8E9MyYfmPaenRE3YoIIVGT5U1zg/mTc3WkI9QclzdVM7rfi/K19ACYBqtzmf6ot034cX8FHXrehO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720652869; c=relaxed/simple;
	bh=yBMJi42jIhEJk9a8J22CKGftLS0ND1FBlQitugAfBqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWSldEbGQhBR/oojUTKxhuEyzy2dCpibjTQOi6nDXIwSs+SIyizDKy5rYcD4LRy3/qz8mduZHPt/KBG20ePFLG9H6aqGP3Bl/CI6qmKdNy14kOtZav2PkOdtcr8P6baUkvywVRSmpFxx9XkC5wM9vTtwp3TXLvo0BRe8pZMWTRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aoX/waoN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79f19f19059so17812085a.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720652867; x=1721257667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBMJi42jIhEJk9a8J22CKGftLS0ND1FBlQitugAfBqQ=;
        b=aoX/waoNgPsiZmmZc09UVsB2wFzX7mBpt9RFoY0ocbxvm1snNYzVRg9/mrur5/fQ1Q
         +NMtsThtrbMHZr8DOfX0Aj1NUHrcPNwee33FXWeoyfEaqEO7FZN+dByAPUIxZE/msW5S
         FrPsiM1VWDHjSI+JfgFqANTvrFgMxM3Ct8/qbAkeiPZvOrCE0UP4l7Tz0q6whfEt9df+
         hX1xrjV1zf/SuRE0P+LvXw530CFkZ/BQAV5VfPVTXLgtklk+cvEJLr6KABgqJDB6aMHi
         XNzXPAWLue7B9S1Yhmjs8MiCEYyJzhKshS6i2SPzc7Lwgsm9XcfNxSR8haP2+syA43ZD
         Q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720652867; x=1721257667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBMJi42jIhEJk9a8J22CKGftLS0ND1FBlQitugAfBqQ=;
        b=leddM8u5h+61htjAluB/cmqqHYrjheL5O3ap9kHKgjP9xon79JxjuLpLVwpQXtsHJ1
         fhba95iabRw+Gv29DhIA87F1S4+IyfTxCGhPscUWPcJgUX7PuqOurDPwUn6gA4exVutZ
         plHKUtgykeoD9qzd7uesk8RefFa/1zxbaa9edpMqFo7vHlkdtVfhDTTCC7eopse6gvUF
         MUTefUABxzqUTtM6k2EDN1Uo4LSVNGD+VfbwgM1oBD6x7PMx9GVCNAlHtqwfos4xQiXw
         kZi4fzMGIdcn3DluzzNeQbLSaWJD9LxtWGUd5DscYJjJSZTOFiYmXuSVhOMf+m7u+WsG
         2Kqg==
X-Forwarded-Encrypted: i=1; AJvYcCX+80lMP/aJRr6pf+RWA0tDsjioay4+rgOI5j0dZv5LoLgw6C7Is65ce+j89AdwEw31duNOWI0FjjDq/H8+3m2ankSkInQQ
X-Gm-Message-State: AOJu0YxRjMvha4OuqQu43yl+JJ1pAZHPO7m6NPrDWzVp+btAni1xgxvD
	JQteulNoYTj3pbxXOn3T2c+nismwvWXeCihrDkdD09mdW+gpeREf7LDZ/l8toe2zGr3NBd4XVOg
	qF1h2vAM84p6ohV4pSvJbdsAXM6JoUR4iQJqb6CQymGaStt9ayNVuxJk=
X-Google-Smtp-Source: AGHT+IEHZ8tBcWBbnKj7rIXKmXq+dkhHT1ciEfmPBniYNlAs5Ct8TtMu1e7Od7GOSI9ixzUxChThDU5SpmBhA3YzYrM=
X-Received: by 2002:ad4:5cab:0:b0:6b5:8f2e:376b with SMTP id
 6a1803df08f44-6b61c1af4d4mr81582606d6.48.1720652867058; Wed, 10 Jul 2024
 16:07:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710203031.188081-1-anthony.l.nguyen@intel.com> <20240710203031.188081-11-anthony.l.nguyen@intel.com>
In-Reply-To: <20240710203031.188081-11-anthony.l.nguyen@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 10 Jul 2024 16:07:32 -0700
Message-ID: <CAHS8izNrmM1=vEwYWHizHFG2-Kdq2oKhQo9ZSSy6Z2_qoxVqSQ@mail.gmail.com>
Subject: Re: [PATCH net-next 10/14] idpf: reuse libeth's definitions of parsed
 ptype structures
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, netdev@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	lihong.yang@intel.com, willemb@google.com, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 1:30=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>
> idpf's in-kernel parsed ptype structure is almost identical to the one
> used in the previous Intel drivers, which means it can be converted to
> use libeth's definitions and even helpers. The only difference is that
> it doesn't use a constant table (libie), rather than one obtained from
> the device.
> Remove the driver counterpart and use libeth's helpers for hashes and
> checksums. This slightly optimizes skb fields processing due to faster
> checks. Also don't define big static array of ptypes in &idpf_vport --
> allocate them dynamically. The pointer to it is anyway cached in
> &idpf_rx_queue.
>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

