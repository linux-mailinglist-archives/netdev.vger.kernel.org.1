Return-Path: <netdev+bounces-244475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B84CECB8941
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 11:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61183009113
	for <lists+netdev@lfdr.de>; Fri, 12 Dec 2025 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA02F9DAE;
	Fri, 12 Dec 2025 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VSUHwaq0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B305315D24
	for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 10:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534282; cv=none; b=eaa1Y7eD7S8peOOEF2R8lzSdRFPsMM7ev/AVf3qMZN5DoK5quf0zlTBfM5PN12fg/d51hsSv9xqJHeyNKmEuoEXz1Z+ciNUA9D5EXHW0Mc17zzinpt6e3DfvFzO2zxhZKw7cXodjAVDIJh5ACgYA4Wr8qhLKetMPVdjhfqKqOUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534282; c=relaxed/simple;
	bh=jUBbdNA0D7wl5Of8wIhQvD/cNouINRAaKp7gfaAbYsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pESGgPiGmat5S8VssYk/VU3CuoMePmpOMplxJAMLOLyuEeIy6d9x4Dbsc+qxAjdewfaQhegDhVzgnOuy++kS5xw/BF74HbPvqGags8t4hxo9g3Hwg3c5wVzc6v2QD0jRI2It537crSQR8S8FV0Nj5Xa78+lY09oUKJBtqKKACfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VSUHwaq0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso575297f8f.2
        for <netdev@vger.kernel.org>; Fri, 12 Dec 2025 02:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1765534277; x=1766139077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CKOAsLIoj501BPNNBKvYFY9bh+S/ciRcjGl7bJKocF4=;
        b=VSUHwaq0BbG/y0LxJvY3oNRJhs1bnNnSGmTrfUkOqE46bNCSRoWs3B0LRyLxP5pjEu
         jNEiKEjjsEbj5IzuZGfcpaQNoED2EOMbygX8kVCpuF9r/CuaocOmESAJ/CP4VC8a9uvD
         3140IvQYoyOTqnGhOuSwDSvoTacLkMaxFjKQ/LW3Cu9PJQYpG1b6q2ocYYyZc+CBP3MB
         RGzdhdtcMil8Mo9Sr/t8dhCAH3ISADgjNa5eWmX5kaXlEFGryw2P2Eu6XvB8NNX7RbcF
         1HU4RDsr+xO6sdHvMdC36x4/F7NSYtkFqbemZJ5jZYY/qILZjMcnWPWuPu/UdB/fm+B4
         7VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765534277; x=1766139077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKOAsLIoj501BPNNBKvYFY9bh+S/ciRcjGl7bJKocF4=;
        b=RbkpRd7/x0XCcu8z5QJZ1MBvr0lB6grvba6ohRC8jKyX186RDJM7fyNnQfCxO+GGcw
         gdst5COng8Xl+jMaH0x3mfAqOBHxQ+9pBy8XuT2BnmaYYsUBIZ+zX5P88CW8gflUFc/Q
         ZcErzSC3+PZRj2lhkW1Sbsftsz0YGsVy1CGwOq82SX+jhfxc/Rf17x16xwpXLKfUUuFn
         /WhvAba7PJ+rGI5Gsewo3PaFA+GBtPbBAbtkTEeFB+V4d2m+GMg8xOQri/dcU4Gqfmn9
         ttzDNCCJU+qtH3CzebmMM9o553y7+ve3dW/SHp1K94woT98/bPkMLirO+cJuASsra1Ok
         SKjw==
X-Forwarded-Encrypted: i=1; AJvYcCUdGf97ic4LOzV5Ty3SapXiYZnUMQLjH0eblmhsnLcl70MzO/1LsE6+BD0g7UETRvgG0DHtTFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v1oqYiy3PkaCIFNsUpO3hXlmyoZ8lZoA2i/mcvwe5hb5QPSZ
	RZrpar91ueBHDLjvqB9qMMAAM1s6epRUGzWUsOBQH0O009eJ1RC1j3vZW43K2cH5tac=
X-Gm-Gg: AY/fxX6T86xX3X8RoF6b2/wAcT5884qWHLj0goAey8ghSN7OZhbrbgLKaNDjqBVlF6j
	ym66G3y0V8HMqJ54hTUl0Et6YmwP8KQtDfBG45adU+AyqZCSmcjxNlWDg8n9QUxjPYSltVkOS5Q
	61e9ze+yGjKAT6GqbMjSHPMhqoi5RaDDK8oXVgoTCamuHRsgMQC4Cu0yYnLZ9i1ekfyDtwJ0AFs
	ES8JxHN+hutwXXorh6qzeZZaxSrOlSNfFayUfQWgF/FKGZXYoBzt0GScGO8oxCSlGNwWsixqWEI
	PdthP3z0WzJcM+eNH6xyp7Ysd2wg+fU21hQ4siIjRrNQvIr3wLFUUimW3ematuP4VIdlHUQf1RK
	OnHIwjp9b+iYseCLaiVh05Yj3iAneC5G9bjIA5b2FNR3Cf7MaY0XFyRr0Fu08ThtZUskuKTWPcu
	8VXia8tBLQV4mDSU9CD1IdcHM=
X-Google-Smtp-Source: AGHT+IHhQMv/wumfxkUs7RY7/5LZ81Ga87Y5cerOtn8qPQeJoGpEIkqlrBqDMQU6WDyGHfGfvcHANw==
X-Received: by 2002:a05:6000:1849:b0:42f:9faa:50b7 with SMTP id ffacd0b85a97d-42fb44bae18mr1528176f8f.17.1765534277426;
        Fri, 12 Dec 2025 02:11:17 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a66b1fsm11787990f8f.9.2025.12.12.02.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 02:11:16 -0800 (PST)
Date: Fri, 12 Dec 2025 11:11:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dharanitharan R <dharanitharan725@gmail.com>
Cc: syzbot+422806e5f4cce722a71f@syzkaller.appspotmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] team: fix qom_list corruption by using
 list_del_init_rcu()
Message-ID: <eriix4z5ts2rguelucqnz2w5fsctkyj6yyedrajnhcmmv7zzxc@fxdvoyrysnyg>
References: <20251210053104.23608-2-dharanitharan725@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210053104.23608-2-dharanitharan725@gmail.com>

Wed, Dec 10, 2025 at 06:31:05AM +0100, dharanitharan725@gmail.com wrote:
>In __team_queue_override_port_del(), repeated deletion of the same port
>using list_del_rcu() could corrupt the RCU-protected qom_list. This
>happens if the function is called multiple times on the same port, for
>example during port removal or team reconfiguration.
>
>This patch replaces list_del_rcu() with list_del_init_rcu() to:
>
>  - Ensure safe repeated deletion of the same port
>  - Keep the RCU list consistent
>  - Avoid potential use-after-free and list corruption issues
>
>Testing:
>  - Syzbot-reported crash is eliminated in testing.
>  - Kernel builds and runs cleanly
>
>Fixes: 108f9405ce81 ("team: add queue override configuration mechanism")

Awesome, this commit is AI hallucinated. Can you do some basic checking
before you send this ****?

