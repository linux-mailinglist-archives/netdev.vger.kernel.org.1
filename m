Return-Path: <netdev+bounces-255488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LZ5OQ5Mfmm/WwIAu9opvQ
	(envelope-from <netdev+bounces-255488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E0FC387C
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0031D3019FF9
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB5536683D;
	Sat, 31 Jan 2026 18:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ff+QUqlx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E55366054
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 18:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769884684; cv=none; b=Yda+dSbqmmzLUR400gdCJVyX8b3lRDElEUUkpJkmvHz4V6oh++ZZkxvCnNuJLOISO3j0KlfzNVjbR+OfkJs8q/kUM+QyyFBqRa5G/Hyd5Piwh0I03U5crjGtLa0j1+20QyjwxxF9DrDU6f3QgWhChUogWwanVfXZ1wFhHGdVE6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769884684; c=relaxed/simple;
	bh=eQO+qr/OAGr9BumSBlJp5RbhUoi9LqCr0xzqBeub5g4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=U41JbdH9JtjYiIeCh/JPvIxgLPPsx1o5pnPr1Gvg1U7xv7GIVJlEDru5cvii4V7JKvKBtflKqF6kBvCLa8s/WxLFv0ObwYfUX1yb5bizM/N3vGKctOVATIQSOfdAGZObh6rJuAjToMBshlR+qQyrM8I5iSSQ/KPwF4YaontFUi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ff+QUqlx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79456d5ebf9so30532347b3.2
        for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769884681; x=1770489481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTDA4EVY1dnSx40dh4iSEtt/xAzscLfbujiihQuN6II=;
        b=ff+QUqlxZktBpcFgaxIRBYpmf/MiVlduPaQytdwY8X7/sLXiO3FUeBR6ANBRKBXZiE
         BfwAfYfMAsKkIs3Tmq0hoQP8rFSRV7khEeVyzcO7FgayplnfG8FigTaJ+vxDIDmXbx+e
         WutNRTblft6QgAZOzbQO6yTCG0bw/A7Eq4/W61z4P8sf/sxwLDwAmNedZeK39bUgAIld
         tW6GLaN3+UOJEXvEVq/WjfsZJP8EcxWWQr8TnR9URsLwok8KIu3uETsn/71Gpozyocr1
         W3pPy2I32OgGf7uj4zlpC4hV81/8WRdLsb8dB7U25qUhhz5vPP4JQ87WOY2c87PW8Oje
         gzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769884681; x=1770489481;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTDA4EVY1dnSx40dh4iSEtt/xAzscLfbujiihQuN6II=;
        b=gUPEbXPBOFVgG1e/DNRLv/Wvplttb2aApHwtz/cCcKFibjkq1vKXV2PjDWYn0Q0j21
         KoXAeJr+bHhT2EItlIj7/VXnLX7d2iRmpYtSryA8NY6xqPoRRDv/ftTGNYGMZp8Kei3U
         gPatiblYXXZsKK3kh1XeBc58OnYNd9yA0vT2hHZZqfMS36sDZOWA4FpTT4lNHMvvzH7K
         noqm+6rjSpS2qYhLqoA8YHqpwn2Pj4KhyzWOctdiuzjuVWSeBs2WsBAkpvv7f7u9Eb4Z
         jHolQW/qO4MwQKTjH9zTaJMIyUeDlQpMZomoPOQJGnYNK1mRdwS1m3nqwHpJHejavINs
         LWHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtP9/cpCF96XDoFEjek2bSLkXC5K/rs0Yvp7wEje1Nx/i5U068yH+SgwXmDdI4aPY9xDWFyDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKFAFBRnSWU5U+5pcVvoT5i49+M0MnYlpG0hh6OGvh9TVirl0
	i/ld/1giDqtTsxuRI4+rTPjmQcpHlSI0Rkjcw5GN12CIRFU8O+uXY1ie
X-Gm-Gg: AZuq6aJZn27BjniX9Gsga/G9NKcdvFczJ+onQ9a0uolM/Y0uCeRRKl+EVp5BodsFvOj
	gGkDENdrVa1vGST7CYXqTWJkEsuxwaIsC+JBuKsfq1/rOJEnE1ECfJQDM1UuE6Dnsba5etq1ONL
	NFFtQy/4lA+FX/dnSvrjGxkIkJLrRe/ALodnOednmkr9IYpFLLWr+wMlEN49oAPfmb3VupEuIOH
	o4V5G1AtVJ49fRUSmLrNEVVVjfH+w5HII0fUr5yxl4X4/i9MQLWzA972XtvRmmrqP69Mgtn9lzE
	+WBLcMhfW00Mo7JCQxtWCxhwzpv6nYUqFYMUeTbo5gpOilHeO4LsEQ0kUO/yb8HwifV7xck8e3a
	8jcqtlFfk7HaoOqUeyluEDuWryBvmBdm3/S+hRtynBlYT5dNKD2aTppKDEhamxUmuGQBXagq/yF
	Fyzu/b7aje9Fu0llVS5ExVyNl/smD3xEw6qn/K7OmX7RgkSoXd224VOXVU7UE=
X-Received: by 2002:a81:ee06:0:b0:786:6179:1a47 with SMTP id 00721157ae682-7949dfba546mr42643307b3.44.1769884681521;
        Sat, 31 Jan 2026 10:38:01 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79482766c5dsm48500557b3.12.2026.01.31.10.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 10:38:00 -0800 (PST)
Date: Sat, 31 Jan 2026 13:38:00 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1c864b559c885@gmail.com>
In-Reply-To: <20260131095047.2096ac8f@kernel.org>
References: <20260130192912.826454-1-kuba@kernel.org>
 <willemdebruijn.kernel.29ba7c9e89f32@gmail.com>
 <20260131095047.2096ac8f@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: rss: validate min RSS table
 size
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-255488-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 58E0FC387C
X-Rspamd-Action: no action

Reviewed-by: Willem de Bruijn <willemb@google.com>

Jakub Kicinski wrote:
> On Sat, 31 Jan 2026 12:18:55 -0500 Willem de Bruijn wrote:
> > > +def _test_rss_indir_size(cfg, qcnt, context=0):
> > > +    """Test that indirection table size is at least 4x queue count."""
> > > +    ethtool(f"-L {cfg.ifname} combined {qcnt}")  
> > 
> > Remind me: does this work with devices that advertise RX N TX N rather
> > than combined N?
> 
> It doesn't. But I haven't seen a device which doesn't at least
> advertise combined made in this decade. I started typing this with

I was indeed thinking of mlx4 as one example.

> support for "rx" vs "combined" initially, but it complicates the code
> for no real benefit.
> 
> If a driver which doesn't have "combined" starts reporting results 
> to NIPA I'll care, right now - CBA.

Fair. It's good to gracefully and skip on older platforms.
I guess the test does that by virtue of the KsftSkipEx if
combined-max < 3. Ack.

> > > +    rss = _get_rss(cfg, context=context)
> > > +    indir = rss['rss-indirection-table']
> > > +    ksft_ge(len(indir), 4 * qcnt, "Table smaller than 4x")
> > > +    return len(indir)
> > > +
> > > +
> > > +@ksft_variants([
> > > +    KsftNamedVariant("main", False),
> > > +    KsftNamedVariant("ctx", True),
> > > +])
> > > +def indir_size_4x(cfg, create_context):
> > > +    """
> > > +    Test that the indirection table has at least 4 entries per queue.
> > > +    Empirically network-heavy workloads like memcache suffer with the 33%
> > > +    imbalance of a 2x indirection table size.
> > > +    4x table translates to a 16% imbalance.
> > > +    """
> > > +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > > +    ch_max = channels.get('combined-max', 0)  
> > 
> > Same here: not all drivers set this.
> > 
> > Perhaps we should skip if absent?
> > 
> > And does combined-max mean all queues across all contexts, or per
> > context?
> 
> Could you rephrase? Not sure I understand.

I implicitly assumed mutually exclusive sets of queues associated with
the two contexts.

If max channels is a driver global limit, then cannot 
exclusively assign max channels to both contexts.

But my assumption was wrong of course. Multiple RSS contexts can have
the same queues in their indirection tables. And this test does not
include any flow steering to an exclusive (set of) queue(s) for the
additional context.

I had not previously given any thought to how additional contexts'
indirection tables are (expected by the kernel to be) initialized.

> channels are interrupts, we use it in place of max Rx queues because 
> we don't have an API to allocate queues directly.
> 
> When queue count is changed and the user did not set the indirection
> table of the main context the main context's indir table is auto-
> -repopulated. It may also be resized.
> 
> The indir tables of additional contexts are not repopulated.
> We do not have the concept of "default" indirection table in 
> an additional context because it has no practical use (just use
> the main table if you don't care about the queue selection!?)
> Since we don't have an explicit API to size them, (yet),
> we expect the size of additional contexts to follow the size 
> of the main indirection table.
> 
> If a table is resized the expectation should be that the driver
> folds/unfolds the existing table eg [0, 1, 0, 1] can fold into [0, 1]
> or unfold into [0, 1, 0, 1, 0, 1, 0, 1]. Resizing tables of additional
> contexts is currently broken / no possible. My colleague is supposed
> to be working on fixing that but appears to be making slow progress :/
> 
> > The test seems to imply the second. My intuition was the
> > first. Is it clearly defined across devices. per ethtool_channels,
> > seems per device?
> > 
> >   * @max_combined: Read only. Maximum number of combined channel the driver
> >   *      support. Set of queues RX, TX or other.
> 



