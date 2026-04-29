Return-Path: <netdev+bounces-282495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJdqHuhy8mnVrQEAu9opvQ
	(envelope-from <netdev+bounces-282495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:06:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8918C49A643
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11FE53031833
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BBD388E46;
	Wed, 29 Apr 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVLDABHH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104024EAB1
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496630; cv=none; b=J1KJmtcJeKFqpoxubToE718bl3kHbODYT7kbK17Ptfrje7QYm2s9LjeRtAhcyowxg82f4lH0CAAUy1AMRZMozk//fmVRSzk14MqP0ffj3XHTUGhuYZZ5O/A3D3Ro4kecl+sedTXIhnqyqf/jcFzjTiES8ZoRbuGVECkTPKLUBlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496630; c=relaxed/simple;
	bh=2aA3uWTswagHEVLFA8v5skfAX/JT54EYEV9OQ+OofHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pnt6MLVfD2vMz3LpusH8QxHABv1j+5084Q0PuIpZrkD4H/XVzo2T0dKPMgP+5JockAebQ25hpf9xY1aLAGKo0oxN0yUOWPLOStDQALLpoUlwzBHf61sFwZRzjaq3xRAQY0vi0nj/DIsEpauGCb2JSgVIuLNnELfPM+jnxYTctnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVLDABHH; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so1669185e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777496627; x=1778101427; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eaYTnlxpHCY09/j5CrSkFztBrg3e6wlR9rFliILkCQ=;
        b=MVLDABHH2s+wca68H4L+y5daBBNCnTUMhWl6HRklW6MSdEAY4a6yOrY5kF9H2KYkxy
         nMNeIbT2Bp9W649poDIzsnnBlgtFphG1BsOmUM7RBiqNYf9eo7Z6bYShIjfKQgNufM2J
         1Tg61FURYlgeIfbFgNo8oKo1nzyRdmOqwVd2Ipzp4KKbZUVS+vR9elLc79ExJ/79Ijp2
         YDyL72gafLeamh7GrT0yuUYsnCdFACHI2ENscvafXVJsfrbQitd3Xgq5bME2LnQ1yAoh
         ob1NstAwBzNdtWtfzA09d5ECVRx+U5gXGcbSukpebnoPW1y8rFHisrwQ2v+LDiJ6g25D
         sqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496627; x=1778101427;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9eaYTnlxpHCY09/j5CrSkFztBrg3e6wlR9rFliILkCQ=;
        b=VvtzGvtN2PF7C+jbXtH4sujQaL/USuUqQ+6AieYJzAe5xyGD9Pca0SnO80a9SlmN7N
         E6XwAX0zFOIOR11JYsb8KSLz3bOhj1Nf6X5+H9aqEXCUYS7DXA3b1VXLwpTeRyYVRsPi
         GFTIT9KdW+YebmJ9zpMSypEiwdCboRJt48H9hofrEB1mPx0CwVvJiOQctxv12twxZRG2
         eoYtxfSPnSYkm6hGDbWv2D9Rd3g+f8+FgNY93rV75HzoRycsl/WyxiMVzD/hud4twJC3
         hg7nQ2deNMEibnuSwlBOLGmV30wsLlLHO9aAGAP+u2WIe8XZuJ12uGC/TEYFBoaDMFF8
         /v9w==
X-Forwarded-Encrypted: i=1; AFNElJ+fAjiLK96oHb2W86XuUwA22bYMM/dQxeCNWFtAIVA41Nl4ORRwf2P0ZD1+Sinmz0dqDdNmWY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI8tYWFmE7+cCvb4/beft7yol9V8/nPynPeoKzixGkgL2mtrOt
	CZNC4bFXidnZizQndFw4hNtDfgadaKFTkLcahmS+/3BMtbD8gPk/sSGw2JH5
X-Gm-Gg: AeBDieuECpzt9+36GnR5WFTKfYvN+VPzr/3Nh13EX6jTlCiR1HbAGdNKcAcdsPvr6QQ
	upsb15Lq3OP63L6D5dt8f32qc9Wzze5SDpICRyxGJh0PjiE1gJxF0IH0mohyeKFTKFOX/8N1Wgt
	JQYMhtqsMRE5fjtpL+6dGLkfvoxEUF4LCxNCBFtt4ZrqPeh0EjVtf+ka9hudo5RABDhIv23mxZe
	BG0IXoTE8CIOVIiIPMF7F/ErqksUrf/FFP0PKICAEuJpUFo17BGhYrGE0REWO925IgW2ZOgT6Ln
	TzFD4JJc8mI1MfjRZvDEUbXcXyhWeJwmPVrPT18rTS3XNyAe7Y/qRFerxb9afdhn74h7P/SPhuA
	Qf3AEvi+7V8iOb8CIe4aRyB1arr6gIGPYzykwvXXoUUCIiT94RbFXzToTtzHhZerL/2OvsJC2tD
	hY0c+O6iCbxf/ZIA==
X-Received: by 2002:a05:600c:350d:b0:48a:57e1:d8cc with SMTP id 5b1f17b1804b1-48a83e7055bmr3924695e9.9.1777496627067;
        Wed, 29 Apr 2026 14:03:47 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822c832fsm29134635e9.10.2026.04.29.14.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:03:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] netfilter: fix NULL ops race in iptable lazy init
Date: Wed, 29 Apr 2026 21:03:44 -0000
Message-ID: <177749662469.1430165.8044688741351868980@talencesecurity.com>
In-Reply-To: <20260429175613.1459342-1-tristmd@gmail.com>
References: <20260429175613.1459342-1-tristmd@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8918C49A643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,talencesecurity.com:mid]

On Wed, 30 Apr 2026 Phil Sutter wrote:
> Is this true? Your patch moves the ops allocation, but new_table->ops is
> still assigned after xt_register_table() has returned. AIUI, the race
> window is just reduced, not eliminated.

You are right -- I missed that new_table->ops is assigned after
xt_register_table() returns. The table becomes visible via list_add()
inside xt_register_table(), but the ops pointer is still NULL at that
point. Moving the allocation alone does not close the window.

We cannot assign ops before xt_register_table() because we need the
returned new_table pointer to set ops[i].priv.

Would a V2 that guards the pre_exit path instead be acceptable?
Something like:

  void ipt_unregister_table_pre_exit(struct net *net, const char *name)
  {
  	struct xt_table *table = xt_find_table(net, NFPROTO_IPV4, name);

  	if (table && table->ops)
  		nf_unregister_net_hooks(net, table->ops,
  				        hweight32(table->valid_hooks));
  }

This way cleanup_net simply skips the table if ops has not been assigned
yet. The register path will either complete and call
nf_register_net_hooks() normally, or fail and clean up via
__ipt_unregister_table().

Thanks,
Tristan

