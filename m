Return-Path: <netdev+bounces-139261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3699B13AA
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 02:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CD1F21BF7
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4317C;
	Sat, 26 Oct 2024 00:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT/fz7BY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C43847C
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729901086; cv=none; b=aBMCMRz3x8us+e69QttjTydsPyf3uKuC+OAF3KOJE7MtgVZ3BvDvl1RIhHIDB4UkoftyuBPejVcjs7xz2SRLdZDOv07hPCRX+951uro21g+e2Jluuw1emtmSObMcf3itJ9RhuTNOKZWuHkew78eBP7gUDyXAZMqCRhyCUMwD16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729901086; c=relaxed/simple;
	bh=MjnMJIfvHdcgXn2sAI9ZN6oghS5uL7+ZmlJFLwCcHlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE6ob/P9nK6CFpIQ3prvnGGViWgJwZNWACJBmYExlMeJxCTGGvngQNuhkbH2/9mHO4fijtLeafFQvjmkP/yi7zv5OOdr6un6xeOhiejLTf9CZg7t9btAICc3S4Nw8zX+B+0GAyFGjj+/LOkz0FYkoyetm/EH9P/zJOETmpvnUqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT/fz7BY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ca7fc4484so18268145ad.3
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 17:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729901084; x=1730505884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VTM9w9hTkIzlQo2IYQ5Z7G4O9imELZg7QgVt5hYyXvE=;
        b=IT/fz7BYhw+Ifxnb8JXH8m9YBC5/HvCws96rQnFVpHufAOXlDAnjAAMSNRTOpTEhLm
         oBk1K/Id+rtDKSIfVJkbe8o8f/6pDSA6SZkrtVprDK19DN3kL+7TWyW+xYy7K0nXGaUM
         7kfhmeaNadw9ffrKnw/6vxkwL26bdI26230tsqcwg+VfilAssREuTMPwvonTKA11ly3k
         yUzzxl2yymgpBjbh1zU+z8Zt6FjyIvMUNqW/NwlhbIPbVQcy1FelVM/zS+s0Y2Copk17
         Dk6sni7REGVQ5QY7ND3Wslz2aE2g4Kl1ptpxm51LBHo4cYpFzSv6QKjDdJjZY8Mvy4T2
         laTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729901084; x=1730505884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTM9w9hTkIzlQo2IYQ5Z7G4O9imELZg7QgVt5hYyXvE=;
        b=SZG7YSdQ9TyMYd6adgVZ/xn3p/+pYqTRSTo7gYeWotXV1gX60auY51InOSIo01MtNA
         Qou/5Szx1FrAycE03YqUKZXn873gtw4VLTmObeBGS3fh8E0cKgW4uUg9sBjiM0KRd9ES
         AX9RqoA8J4pzH/QFRuEVnIX5NY0Rkvs2VVXWBJBzp6hLv7ltscNb6JQTfUOTbioZsyi+
         SM5D9hrnUwzuoWcitgWmqYWOC+knZo6Tewk1HEGTA06rZ73QkML8+2KvZq1q0njcTaMA
         S7cfIjvB6VfjpuIFc8HxnISfs8k5ZLCca/TfBD7WzTwTyvTzX/bwQ0y28ljAy5mdH21j
         txHg==
X-Gm-Message-State: AOJu0YzVW1qCrvzJBEjRLdBR/DXIcoJ+mhZkzjk1p/jjh4YGDjo1TLWT
	wwAbACVa4uVqHr+4+4GLP5XY/WEomCzuC/9ESEDwWFCjo7mbED0U
X-Google-Smtp-Source: AGHT+IFTkbQf22BzI8qckE3D2gtUgVIjcMqaDP9K9hM3BZ669pmV/qd4CB1R/pyklbMVfxJ1AigHmQ==
X-Received: by 2002:a17:903:2345:b0:20c:7be3:2832 with SMTP id d9443c01a7336-210c6ae34d3mr11939825ad.31.1729901084126;
        Fri, 25 Oct 2024 17:04:44 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:879f:f366:fb0:247c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf84597sm14754585ad.111.2024.10.25.17.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 17:04:43 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:04:42 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	ij@kernel.org, ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
	vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>,
	Olivier Tilmans <olivier.tilmans@nokia.com>,
	Henrik Steen <henrist@henrist.net>,
	Bob Briscoe <research@bobbriscoe.net>
Subject: Re: [PATCH net-next 1/1] sched: Add dualpi2 qdisc
Message-ID: <ZxwyGtt2V6w3WIIp@pop-os.localdomain>
References: <20241018021004.39258-1-chia-yu.chang@nokia-bell-labs.com>
 <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018021004.39258-2-chia-yu.chang@nokia-bell-labs.com>

On Fri, Oct 18, 2024 at 04:10:04AM +0200, chia-yu.chang@nokia-bell-labs.com wrote:
>  Documentation/netlink/specs/tc.yaml |  108 +++
>  include/linux/netdevice.h           |    1 +
>  include/uapi/linux/pkt_sched.h      |   34 +
>  net/sched/Kconfig                   |   20 +
>  net/sched/Makefile                  |    1 +
>  net/sched/sch_dualpi2.c             | 1045 +++++++++++++++++++++++++++

Please also add selftests under tools/testing/selftests/tc-testing/ while you are on it.

BTW, could it be implemented with eBPF Qdisc?

Thanks.

