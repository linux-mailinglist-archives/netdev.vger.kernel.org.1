Return-Path: <netdev+bounces-151898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA59F1821
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DDA188C59A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D859C1922D7;
	Fri, 13 Dec 2024 21:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FT4Q1qQL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7B19048F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126445; cv=none; b=Nu7wq4rBHG9QLwTL42Qs3vRIukaVTaCSbZB2RuQX2lE6h/3dtRb1xG4yaTnoNxzqGFyADCP1JX1cDLTQN89mtdzwRfNUG0r8ggeFGFjDsMAwF78NE9Ro2v5HACdHuvR9CWtCib9HxTJdzibKcSvdNoIIdgamcmSTAlcd1CxM2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126445; c=relaxed/simple;
	bh=gSyNEpcN2ZbY4H9ORbzvaIDUuWJ/Yxo0+a1TgtMamxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6vs59mSV5aefz1YUPUCj0d3E+t1piQnAmBHHtg3mShJbYn8guEr3/NPbV5+k3k0CRmmDxbm+T6x82AihZDG3rJdZs0oUSYTTPqNMagRsPKSjhnF4UPcAD4k4I2LY8BizpMjgm6/x8tLIUeZEkNupDbaCD9c2Mlt9iwIL4LsFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FT4Q1qQL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72739105e02so2483698b3a.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126443; x=1734731243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVqB/GjiJmYmyOSSLwGXDzti4tsPhIcQpJ5Uo6DF0jc=;
        b=FT4Q1qQLow6UALDlrPXuRGF1CPbKaNp02ykQs/9lwyngFP9cKM/fj2hb/EdwlUqj3G
         GF5uZ0xhdQ75VxyhNuqI/aro2XHEM90fJCZBdpqxQYX2r5e0urvIYyAkdv5ujTGuJ1XW
         hzWen4MIfFd97OHB5sHyDEMaNy5nbvUizlWrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126443; x=1734731243;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVqB/GjiJmYmyOSSLwGXDzti4tsPhIcQpJ5Uo6DF0jc=;
        b=UWTL5Cl1dMt6LhkuYI4lPwbPT+YrkE0d7pwD0MWAFZFZsQy1JPXOT6qv9cdLh88Fnt
         EWb0800tySFJZvADvasHEAzWleUF0UJoV/dEAGfJfsXJX38bqqytEBcGDxqHsd+bVvjY
         QfJNeA+Rk4K/D2F0BoUWmAX69HT70/WbMsrrvdy0ZkMhiJ/LdOcOLMW0bclA4O9LCnyS
         BU5aNzKskfveFUwEhZvdAjW/WAGHP89IiREKdwe8lQJC0rZiaBT76wS9RLN4IXUbQQBX
         uE8gyhzXXEgz21O8drvIRSUzTOD58EoJ6ouWpK1AKgF79CzjtgjhcMj5YmP7FTfWJkSi
         AqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT/tfAjOUWVgd3D25Haws9nby3ClVO2+ibuZvyMvEwU7OBmbKnYchY+4NISJgrtvZVU1YhG2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzidlYew6jw1AQXVNCwt7fAhIOTNwyk20uLgAusyk7kJoCu4M4v
	2OBsZ3jf9XDPj5TH1oESyU+Oy6L0kQxKXilXtPul5kKEF8g1Hcvi3AsFmcuCCWY=
X-Gm-Gg: ASbGncuOF6/Gd5bYDNrZcxFQYraJfrCPX+Nl26FAB92Cu5sal7voZH4/WZLAFE/j4u7
	+pCT3cXZNlWzIDge2p2M5JMepq1q/LnVlL5zjtSRlHb9qNpn0TtQgRCHp/m50dLkrJQ5BAIq4d0
	MvjQO+wMru8BUo6hniU6MxrO5XN17qjv6Wuhu3N0QUJmrgM2uSmV+ODVhehEJK2QSn3+5BpZAMv
	Co47G4D7U46LFpr4VYTL9NukzLg+JTLycal/iKIYijIqarw5/r12vn2E7dGMIp0EK/qObgovrvD
	1EuueZGNyK3XQgC3TiSNQu2u7DUX
X-Google-Smtp-Source: AGHT+IG5EugtjQXxqB177FGmlSSBcMM5rme1KxriIIyA+ifDOLZUoUa/1OcR9z6KC8l2AnXKJKdMaQ==
X-Received: by 2002:a05:6a00:4209:b0:726:41e:b32a with SMTP id d2e1a72fcca58-7290c0e179amr5612093b3a.4.1734126442828;
        Fri, 13 Dec 2024 13:47:22 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918af0ca3sm253877b3a.81.2024.12.13.13.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:47:22 -0800 (PST)
Date: Fri, 13 Dec 2024 13:47:19 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 4/5] selftests: net-drv: queues: sanity check netlink
 dumps
Message-ID: <Z1yrZ7bZq8bTBUAR@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-5-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:43AM -0800, Jakub Kicinski wrote:
> This test already catches a netlink bug fixed by this series,
> but only when running on HW with many queues. Make sure the
> netdevsim instance created has a lot of queues, and constrain
> the size of the recv_buffer used by netlink.
> 
> While at it test both rx and tx queues.

Thanks for expanding the test to cover TX, as well.
 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/queues.py | 23 +++++++++++--------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index 30f29096e27c..9c5473abbd78 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -8,25 +8,28 @@ from lib.py import cmd
>  import glob
>  
>  
> -def sys_get_queues(ifname) -> int:
> -    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
> +def sys_get_queues(ifname, qtype='rx') -> int:
> +    folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
>      return len(folders)
>  
>  
> -def nl_get_queues(cfg, nl):
> +def nl_get_queues(cfg, nl, qtype='rx'):
>      queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
>      if queues:
> -        return len([q for q in queues if q['type'] == 'rx'])
> +        return len([q for q in queues if q['type'] == qtype])
>      return None
>  
>  
>  def get_queues(cfg, nl) -> None:
> -    queues = nl_get_queues(cfg, nl)
> -    if not queues:
> -        raise KsftSkipEx('queue-get not supported by device')
> +    snl = NetdevFamily(recv_size=4096)
>  
> -    expected = sys_get_queues(cfg.dev['ifname'])
> -    ksft_eq(queues, expected)
> +    for qtype in ['rx', 'tx']:
> +        queues = nl_get_queues(cfg, snl, qtype)
> +        if not queues:
> +            raise KsftSkipEx('queue-get not supported by device')
> +
> +        expected = sys_get_queues(cfg.dev['ifname'], qtype)
> +        ksft_eq(queues, expected)
>  
>  
>  def addremove_queues(cfg, nl) -> None:
> @@ -57,7 +60,7 @@ import glob
>  
>  
>  def main() -> None:
> -    with NetDrvEnv(__file__, queue_count=3) as cfg:
> +    with NetDrvEnv(__file__, queue_count=100) as cfg:
>          ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
>      ksft_exit()
>  

Reviewed-by: Joe Damato <jdamato@fastly.com>

