Return-Path: <netdev+bounces-235570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038DC3274E
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 18:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539214234DD
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA63396F3;
	Tue,  4 Nov 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bk2dOcyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7C524729A
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 17:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278790; cv=none; b=YlMbXHowJky2uYFGvPYg2YCUs9pzycxzpFDlQqIpwS5TdmHF9rDYgH0OC9TngVtWrNu6t7Ujjsokx5vNN5OvgMX6vQrcIQ1R+7fCZdX6UV2rfdQ3T5BUGd0p9tBpeTUVnOuTi+EAXyTj+q2+lGLgH9kwrY7VimwQo+OddgEyIfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278790; c=relaxed/simple;
	bh=pJniQzb97axA+WG+7Akj8fNcEvCgdvI8FBy2lcr3XTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlZxSHT2ze6Cfcxrwl1c6PTwJd1CzEm7Q3wfQQaL55BM6Ii0j2VSQPn2QcCfqWRiifq32JPXx7B4jq0W7+tzSwlJnHC4gx7k4lJ5/7y1jZQxeLhOsca8KPDUmx9j5cbrF8V3sSluexLaL0R+VcsyQQ89p3QYcMQb8oiCw7JvaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bk2dOcyg; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-880439c5704so30413476d6.1
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 09:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278785; x=1762883585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJniQzb97axA+WG+7Akj8fNcEvCgdvI8FBy2lcr3XTo=;
        b=bk2dOcygehOYugRBcjTiS2asgnzzU10Svt7hz65WXf3gAKCIySwmDxJSPrdW4Yis4F
         niMM4EnwWqw4Fsh6uGwy+0zTiYAISNjbxvVdviYgWEdr4UNZbvvUpw/KrFw4lLRmtblC
         HJZqUrp9/+sOyGlWoZ6gRLLNDOZ2IYy4MO4JPdSl3k5nvcPkpmZrrIl4FkJ3vqggQtQd
         OLc6KBnOAIDXxcirX/ZNp2DQYeVmQNP6UrAE8qKF0OMhvlcU57vajxDqombkfdo1ViY8
         rk91I1vraLW2DOVfCbAh+r5WuaQXNnxGcVtFqEMU4ad8INfqezYQyA04EvZgOnjieXt8
         PzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278785; x=1762883585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJniQzb97axA+WG+7Akj8fNcEvCgdvI8FBy2lcr3XTo=;
        b=Tkrbr1jaYRdB8Aed36h4zcLgibpf4cAIK52i7dGn9KMhIiH+qc1zxN1EvuPSjvPauN
         j6mQaO/YhV6/FNlWBUqRqyBq9SAq45gWl70ZMEzwGMnzM7wIEI6Oo+BwcZlisAngQMJk
         qO4hxEH6CzTXjxUbNwkuFEuPBPZudbEvdDWsetsrNdkCv8RPtR8OfejHq5bVo/vluV1F
         c88iHC82+/aucdIQOKSRf8d36rveBpeMxjUWfeLgmDWPFzJLla6kKSpnMxfO7M+hfMPS
         w+yAcbs8Z656k5lu2PkRGAuZczT/ujjFvqzSyYxYBrYv4r8wsryycgcxUUWZPMd7FBlF
         Ejgg==
X-Gm-Message-State: AOJu0YwVnOw9ABlBKbHuq1G43edPsqKxZaayRTFZT44Xau4DwVep+/UC
	/eKI2dEaxeOJQf7WSZP0W4zdTxjke8ZPzVmH0PfBjWbXxUqklct//cJb8z5MMj+K0HIOKLYgbNN
	riKnlNPiUaoVrJqXKz7oZWBp/XGc/+ggnGu+YByGYPztKHF46Dotf555ZaLE=
X-Gm-Gg: ASbGncvNUQVzENXrSn3BxZfqbnYkVuaWLxjbwRS4/Mxc2FZYHfQrzb2p8gjJqzP1rFk
	QWstsisIgndEObXd4w4FvuzKjY+9F95zIkq5quIvBrgEIbx4jwsazyVl5nYoo+Ri/LKtzn0bhgS
	peF+gIBm8175IsyO1dbtdFrmVjMJbHOHtQdaSBuOa+EbetzbbFFnVjt2SbS9yWbLUru4vBa00SW
	gYF9Y14NhDdRhWqmOitXaX5qoFVvi8dy/b/LbFeud75XaFkGyJAAMRA+ho/djs4pqp/wZ/9Oa8z
	SXfK9o6jC/ltGfPKfWhsPyjTIFg=
X-Google-Smtp-Source: AGHT+IF0oFXTErGmJ5WGI/sOIZAOzn/VR90rtTnh8WCP0xyCovpK+9iu2K/nS7etdt++1zPwqyiAI8L/3ZLM0VPDtpE=
X-Received: by 2002:a05:6214:20a5:b0:880:2b54:2b91 with SMTP id
 6a1803df08f44-8807115d75fmr7557106d6.36.1762278784460; Tue, 04 Nov 2025
 09:53:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104144824.19648-1-equinox@diac24.net> <20251104144824.19648-2-equinox@diac24.net>
In-Reply-To: <20251104144824.19648-2-equinox@diac24.net>
From: Lorenzo Colitti <lorenzo@google.com>
Date: Tue, 4 Nov 2025 12:52:53 -0500
X-Gm-Features: AWmQ_bnSAGbQ5eq6RanhBWz_oVith8McK7co1Q2Mf9zp3GUa82f7Xg1cyNZ8NbQ
Message-ID: <CAKD1Yr3k9nujqQQ9eM1NGTdCuOguOT_qH+T3vZaUG+XJ1AG21g@mail.gmail.com>
Subject: Re: [RESEND PATCH net-next v2 1/4] net/ipv6: flatten ip6_route_get_saddr
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Patrick Rohr <prohr@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:48=E2=80=AFAM David Lamparter <equinox@diac24.net>=
 wrote:
> Inline ip6_route_get_saddr()'s functionality in rt6_fill_node(), to
> prepare for replacing the former with a dst based function.

Reviewed-By: Lorenzo Coliti <lorenzo@google.com>

