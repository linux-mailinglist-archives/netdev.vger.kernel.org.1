Return-Path: <netdev+bounces-83929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7EE894E48
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 11:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAEE1F21342
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490655674B;
	Tue,  2 Apr 2024 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cF8WCMtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3353E3D
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 09:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048784; cv=none; b=FsfPtofT4G0pY8B/c+hhK9xyNqvTGh2VdFD8jpAzHmnYIU7Q1nKbLJOK2pEgdMazXJAh5mkP7LBXelsCDVkDE1P4CxzWjB3/Skmta+HiNU2bOUwS+4R8tCa0wi/Y2hFJHEkW7sdt2fXdfJIBOXjCqFZIcLVGVcFUFGoR4A8VAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048784; c=relaxed/simple;
	bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ss7xUe3SLBDS3vWcXFsa5cgcvrotN2Gi/kpX+5cLPd3GOmUtLRYTxHX5alEQ7NWkFsG/GQvLQYJxdY/j3r1k+MyUgqiyTVI9TWX0SwM3R/6oD9ZiakpyD7bs0ygVI4E+GkgDz3v6dQJr7z801mKyBZwfplZAdL44UkRz4qThonI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cF8WCMtg; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ea7f2d093aso4557844b3a.3
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 02:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1712048782; x=1712653582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=cF8WCMtgumQtL2EDQCU9C80+oJhPTjV+fG7QYYdutUD+YquBzHhsyn6YaGV1DEgUfY
         aGfaA+bTaw27DUeLcZ27OTsulyA1oB20fkcf8X+rqhZYJE9wzTHa6zdwCLzNkwrZApUo
         rmtk4MkjHMYItADokvuBW/s2hgwRkeqwxPFpZ9cOlwlm4YP4EucYbLFNBSpCqFSQu20E
         g3oc3UYS6zf3ko6Sheg8dn4d79WHVub6H1pj6Hy3eXUfdQgYsC7d8nMOLB4W2YTh9eWb
         3H+UVFqLXgmomhNcZyS1EfoZDz/8fkaY4NAjWi4FGCVe66yPnMxXc0FR0hxKFfP7rgTn
         /ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048782; x=1712653582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZvUEjNrrSg6aftshRDrRAJi+4xS6GvD6H8cljYrsFM=;
        b=lMDA2pUb7MUFuE2709N+7MLPbO5JivbxWPeq6lXtD0bn0edak3LcJyUd0GRiBz2AM0
         X4OJXeeniUW1EiI9TVUvcWOLENUcqtT686OYwSxzpbqpGkwPqNDlGLD3sp3XPjN365LU
         BuaaRxRIfRutoCv7J2lC1eEVro+RdX0EaR5na/bEYs8I+Y66Ik7jKe1U7CA5rslba6Zm
         V5Dx8lvcgJqnUsdBE6duA6BxxSfZSNHxiaJmVgzyKZ/a7q1uub69wiQzx0hTIvEgCjGs
         SVvsH6K89B8XVDv7SuYhjO6Yko3Mm/8+oo71nR7LC21qY3l+b6Sj12CR7o7E1ZbwCmMB
         1DdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiPleyQitxKV77xo3UISleoKlKe5OLn5qL/j5wRkCmT+whYszsl/5BNSpTKK2dICPPBH2UOM6dFI/LZnJWakaLHwbMd/0H
X-Gm-Message-State: AOJu0Yy4CRG8mEn3pn2rEb2CbGr+s0PGv1XrW9oGy0GgJyb2sCNwcVIX
	fwbnvf/if5IVDajYATUlexWQZJ8G/BT96JniZ48GjCxmiCLmjoAOlakrDAm1qwnR8bBNQuxmGyQ
	pRoNRvIJ69hkpzbfqvqmmcXhWescbPrcvzdUMSw==
X-Google-Smtp-Source: AGHT+IF06xagbN5sKJ9EvpgsDV85tb7LWZ5CreUjfXa0X50ku8Pvfe0kXvoKUXz76ondFzi9g5ymjQfN8l2M+t8uJp0=
X-Received: by 2002:a05:6a21:394c:b0:1a6:fe92:ed5b with SMTP id
 ac12-20020a056a21394c00b001a6fe92ed5bmr9413194pzc.23.1712048782167; Tue, 02
 Apr 2024 02:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d8fd6b06141e73a4@google.com>
In-Reply-To: <000000000000d8fd6b06141e73a4@google.com>
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Tue, 2 Apr 2024 11:06:10 +0200
Message-ID: <CAGn+7TUvamrV8Ap_O0_mnHo0ZgS=0e=HmVWqwqsEYcg95nGT5A@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in wq_worker_tick
To: syzbot <syzbot+8627369462e8429d7cd6@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

